using Microsoft.AspNetCore.Components.Authorization;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using Microsoft.AspNetCore.Authentication.MicrosoftAccount;
using Microsoft.AspNetCore.Authentication.Google;
using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.AspNetCore.Diagnostics.EntityFrameworkCore;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.Data.Sqlite;
using System.Runtime.Versioning;
using off2.Components;
using off2.Components.Account;
using off2.Data;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Services.AddRazorComponents()
    .AddInteractiveServerComponents();

builder.Services.AddCascadingAuthenticationState();
builder.Services.AddScoped<IdentityUserAccessor>();
builder.Services.AddScoped<IdentityRedirectManager>();
builder.Services.AddScoped<AuthenticationStateProvider, IdentityRevalidatingAuthenticationStateProvider>();

// Configure external authentication if enabled
var microsoftClientId = builder.Configuration["Authentication:Microsoft:ClientId"];
var microsoftClientSecret = builder.Configuration["Authentication:Microsoft:ClientSecret"];
var googleClientId = builder.Configuration["Authentication:Google:ClientId"];
var googleClientSecret = builder.Configuration["Authentication:Google:ClientSecret"];

if (!string.IsNullOrEmpty(microsoftClientId) && !string.IsNullOrEmpty(microsoftClientSecret))
{
    builder.Services.AddAuthentication().AddMicrosoftAccount(options =>
    {
        options.ClientId = microsoftClientId;
        options.ClientSecret = microsoftClientSecret;
    });
}

if (!string.IsNullOrEmpty(googleClientId) && !string.IsNullOrEmpty(googleClientSecret))
{
    builder.Services.AddAuthentication().AddGoogle(options =>
    {
        options.ClientId = googleClientId;
        options.ClientSecret = googleClientSecret;
    });
}

var connectionString = builder.Configuration.GetConnectionString("DefaultConnection") ?? throw new InvalidOperationException("Connection string 'DefaultConnection' not found.");
builder.Services.AddDbContext<ApplicationDbContext>(options =>
    options.UseSqlite(connectionString));
builder.Services.AddDatabaseDeveloperPageExceptionFilter();

// Use AddDefaultIdentity for full UI/cookie support in Blazor Server
var requireConfirmedAccount = builder.Configuration.GetValue("Identity:RequireConfirmedAccount", true);
builder.Services.AddDefaultIdentity<ApplicationUser>(options => 
{
    options.SignIn.RequireConfirmedAccount = requireConfirmedAccount;
    // Configure password requirements
    options.Password.RequiredLength = 6;
    options.Password.RequireDigit = true;
    options.Password.RequireLowercase = true;
    options.Password.RequireUppercase = true;
    options.Password.RequireNonAlphanumeric = true;
})
    .AddRoles<IdentityRole>()
    .AddEntityFrameworkStores<ApplicationDbContext>();

// Register services
builder.Services.AddScoped<RoleHelper>();
builder.Services.AddScoped<TicketService>();
builder.Services.AddScoped<CommentService>();
builder.Services.AddScoped<AttachmentService>();
builder.Services.AddScoped<NotificationService>();

builder.Services.AddSingleton<IEmailSender<ApplicationUser>, IdentityNoOpEmailSender>();

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseMigrationsEndPoint();
}
else
{
    app.UseExceptionHandler("/Error", createScopeForErrors: true);
    // The default HSTS value is 30 days. You may want to change this for production scenarios, see https://aka.ms/aspnetcore-hsts.
    app.UseHsts();
}

app.UseHttpsRedirection();

app.UseAntiforgery();

// Add authentication and authorization middleware
app.UseAuthentication();
app.UseAuthorization();

// Ensure roles are created
using (var scope = app.Services.CreateScope())
{
    var roleHelper = scope.ServiceProvider.GetRequiredService<RoleHelper>();
    await roleHelper.EnsureRolesCreatedAsync();
}

app.MapStaticAssets();
app.MapRazorComponents<App>()
    .AddInteractiveServerRenderMode();

// Add additional endpoints required by the Identity /Account Razor components.
app.MapAdditionalIdentityEndpoints();

// Add GET /Account/Logout endpoint for Blazor logout via GET link
app.MapGet("/Account/Logout", async (HttpContext context) =>
{
    await context.SignOutAsync(IdentityConstants.ApplicationScheme);
    await context.SignOutAsync(IdentityConstants.ExternalScheme); // Also sign out from any external authentication
    // Always redirect to root URL after logout
    var returnUrl = "/";
    context.Response.ContentType = "text/html";
    await context.Response.WriteAsync($@"
        <!DOCTYPE html>
        <html><head>
        <meta http-equiv='refresh' content='0;url={returnUrl}' />
        <script>window.location.replace('{returnUrl}');</script>
        </head>
        <body>
            <p>Logging out... Redirecting to <a href='{returnUrl}'>home page</a></p>
        </body>
        </html>");
});

// Check for command-line arguments to handle the admin password reset or hash generation
if (args.Length > 0)
{
    if (args[0] == "update-admin-password")
    {
        UpdateAdminPassword(builder.Configuration);
        return; // Exit after updating the password
    }
    else if (args[0] == "update-admin-password-silent")
    {
        // Just generate and return the hash without updating the database
        string password = args.Length > 1 ? args[1] : builder.Configuration["AdminSetup:Password"] ?? "ChangeMe123!";
        var hasher = new PasswordHasher<string>();
        var hash = hasher.HashPassword(null!, password);
        Console.Write(hash); // Only output the hash with no additional text
        return;
    }
}

app.Run();

// Function to update admin password
static void UpdateAdminPassword(IConfiguration configuration)
{
    Console.WriteLine("Resetting admin password from appsettings.json...");

    // Get username and password from appsettings.json
    string? username = configuration["AdminSetup:Username"];
    string? password = configuration["AdminSetup:Password"];
    if (string.IsNullOrWhiteSpace(username) || string.IsNullOrWhiteSpace(password))
    {
        Console.Error.WriteLine("ERROR: AdminSetup:Username and AdminSetup:Password must be set in appsettings.json.");
        Environment.Exit(1);
    }

    // Generate password hash
    Console.WriteLine("Generating password hash...");
    var hasher = new PasswordHasher<string>();
    var hash = hasher.HashPassword(null!, password);

    // Update or insert admin user in database
    Console.WriteLine("Updating or creating admin user in database...");
    string connectionString = "Data Source=Data/app.db";
    using var connection = new Microsoft.Data.Sqlite.SqliteConnection(connectionString);
    connection.Open();

    // Check if admin user exists
    string userId;
    bool userExisted;
    using (var checkCmd = connection.CreateCommand())
    {
        checkCmd.CommandText = "SELECT Id FROM AspNetUsers WHERE NormalizedUserName = @normname";
        checkCmd.Parameters.AddWithValue("@normname", username.ToUpperInvariant());
        var result = checkCmd.ExecuteScalar();
        if (result != null && result != DBNull.Value)
        {
            userId = result.ToString()!;
            userExisted = true;
        }
        else
        {
            userId = Guid.NewGuid().ToString();
            userExisted = false;
        }
    }

    if (userExisted)
    {
        // Update password hash, email, and role if needed
        using var updateCmd = connection.CreateCommand();
        updateCmd.CommandText = @"UPDATE AspNetUsers SET PasswordHash = @hash, Email = @email, NormalizedEmail = @normemail, UserName = @username, NormalizedUserName = @normname, EmailConfirmed = 1, Role = @role, PhoneNumberConfirmed = 0, TwoFactorEnabled = 0, LockoutEnabled = 1, AccessFailedCount = 0 WHERE Id = @id";
        updateCmd.Parameters.AddWithValue("@hash", hash);
        updateCmd.Parameters.AddWithValue("@username", username);
        updateCmd.Parameters.AddWithValue("@normname", username.ToUpperInvariant());
        updateCmd.Parameters.AddWithValue("@id", userId);
        updateCmd.Parameters.AddWithValue("@email", username + "@example.com");
        updateCmd.Parameters.AddWithValue("@normemail", (username + "@example.com").ToUpperInvariant());
        updateCmd.Parameters.AddWithValue("@role", "Admin");
        int rowsAffected = updateCmd.ExecuteNonQuery();
        if (rowsAffected > 0)
        {
            Console.WriteLine("Admin password and details have been updated successfully!");
        }
        else
        {
            Console.WriteLine("Failed to update admin user in database.");
        }
    }
    else
    {
        // Insert new admin user
        using var insertCmd = connection.CreateCommand();
        insertCmd.CommandText = @"INSERT INTO AspNetUsers (Id, UserName, NormalizedUserName, Email, NormalizedEmail, EmailConfirmed, PasswordHash, SecurityStamp, ConcurrencyStamp, LockoutEnabled, AccessFailedCount, Role, PhoneNumberConfirmed, TwoFactorEnabled) VALUES (@id, @username, @normname, @email, @normemail, 1, @hash, @secstamp, @constamp, 1, 0, @role, 0, 0)";
        insertCmd.Parameters.AddWithValue("@id", userId);
        insertCmd.Parameters.AddWithValue("@username", username);
        insertCmd.Parameters.AddWithValue("@normname", username.ToUpperInvariant());
        insertCmd.Parameters.AddWithValue("@email", username + "@example.com");
        insertCmd.Parameters.AddWithValue("@normemail", (username + "@example.com").ToUpperInvariant());
        insertCmd.Parameters.AddWithValue("@hash", hash);
        insertCmd.Parameters.AddWithValue("@secstamp", Guid.NewGuid().ToString());
        insertCmd.Parameters.AddWithValue("@constamp", Guid.NewGuid().ToString());
        insertCmd.Parameters.AddWithValue("@role", "Admin");
        int rowsInserted = insertCmd.ExecuteNonQuery();
        if (rowsInserted > 0)
        {
            Console.WriteLine("Admin user did not exist and has been created with the credentials specified in appsettings.json");
        }
        else
        {
            Console.WriteLine("Failed to create admin user in database.");
        }
    }

    // Ensure admin user is in the Admin role
    string adminRoleId;
    using (var roleCmd = connection.CreateCommand())
    {
        roleCmd.CommandText = "SELECT Id FROM AspNetRoles WHERE NormalizedName = 'ADMIN'";
        var roleResult = roleCmd.ExecuteScalar();
        if (roleResult != null && roleResult != DBNull.Value)
        {
            adminRoleId = roleResult.ToString()!;
        }
        else
        {
            // Create the Admin role if it doesn't exist
            adminRoleId = Guid.NewGuid().ToString();
            using var createRoleCmd = connection.CreateCommand();
            createRoleCmd.CommandText = @"INSERT INTO AspNetRoles (Id, Name, NormalizedName, ConcurrencyStamp) VALUES (@id, 'Admin', 'ADMIN', @constamp)";
            createRoleCmd.Parameters.AddWithValue("@id", adminRoleId);
            createRoleCmd.Parameters.AddWithValue("@constamp", Guid.NewGuid().ToString());
            createRoleCmd.ExecuteNonQuery();
        }
    }

    // Add user to Admin role if not already
    using (var userRoleCmd = connection.CreateCommand())
    {
        userRoleCmd.CommandText = "SELECT COUNT(*) FROM AspNetUserRoles WHERE UserId = @uid AND RoleId = @rid";
        userRoleCmd.Parameters.AddWithValue("@uid", userId);
        userRoleCmd.Parameters.AddWithValue("@rid", adminRoleId);
        var inRole = Convert.ToInt32(userRoleCmd.ExecuteScalar());
        if (inRole == 0)
        {
            using var addRoleCmd = connection.CreateCommand();
            addRoleCmd.CommandText = "INSERT INTO AspNetUserRoles (UserId, RoleId) VALUES (@uid, @rid)";
            addRoleCmd.Parameters.AddWithValue("@uid", userId);
            addRoleCmd.Parameters.AddWithValue("@rid", adminRoleId);
            addRoleCmd.ExecuteNonQuery();
            Console.WriteLine("Admin user has been added to the Admin role.");
        }
        else
        {
            Console.WriteLine("Admin user is already in the Admin role.");
        }
    }
}
