using Microsoft.AspNetCore.Components.Authorization;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using Microsoft.AspNetCore.Authentication.MicrosoftAccount;
using Microsoft.AspNetCore.Authentication.Google;
using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.AspNetCore.Diagnostics.EntityFrameworkCore;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using System.Runtime.Versioning;
using off2.Components;
using off2.Components.Account;
using off2.Data;
using Microsoft.Data.Sqlite;

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
builder.Services.AddDefaultIdentity<ApplicationUser>(options => 
{
    options.SignIn.RequireConfirmedAccount = true;
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
    var returnUrl = context.Request.Query["ReturnUrl"].FirstOrDefault() ?? "/";
    context.Response.Redirect(returnUrl);
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
    
    // Get password from appsettings.json
    string password;
    try
    {
        password = configuration["AdminSetup:Password"] ?? "ChangeMe123!";
    }
    catch
    {
        // Use default if reading fails
        password = "ChangeMe123!";
    }
    
    // Generate password hash
    Console.WriteLine("Generating password hash...");
    var hasher = new PasswordHasher<string>();
    var hash = hasher.HashPassword(null!, password);
    
    // Update admin password in database
    Console.WriteLine("Updating admin password in database...");
    string connectionString = "Data Source=Data/app.db";
    using var connection = new Microsoft.Data.Sqlite.SqliteConnection(connectionString);
    connection.Open();
    
    using var command = connection.CreateCommand();
    command.CommandText = "UPDATE AspNetUsers SET PasswordHash = @hash WHERE NormalizedUserName = 'ADMIN'";
    command.Parameters.AddWithValue("@hash", hash);
    int rowsAffected = command.ExecuteNonQuery();
    
    if (rowsAffected > 0)
    {
        Console.WriteLine("Admin password has been reset successfully!");
        Console.WriteLine("You can now log in with the credentials specified in appsettings.json");
    }
    else
    {
        Console.WriteLine("Failed to update password in database. No admin user found.");
    }
}
