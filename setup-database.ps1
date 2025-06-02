# Setup script for the ticketing system database
$ErrorActionPreference = "Stop"

Write-Host "Setting up the ticketing system database..."

# Function to read settings from appsettings.json
function Get-AdminSettings {
    $appsettings = Get-Content "appsettings.json" | ConvertFrom-Json
    return @{
        Username = if ($appsettings.AdminSetup.Username) { $appsettings.AdminSetup.Username } else { "admin" }
        Password = if ($appsettings.AdminSetup.Password) { $appsettings.AdminSetup.Password } else { "ChangeMe123!" }
    }
}

# Define the path to the PasswordHasher project
$PASSWORDHASHER_PATH = "../PasswordHasher"

try {    # 1. Clean and rebuild projects
    Write-Host "Cleaning and rebuilding projects..."
    dotnet clean
      dotnet build -c Release
    if ($LASTEXITCODE -ne 0) { throw "Failed to build main project" }

    # 2. Get admin settings and generate password hash
    $adminSettings = Get-AdminSettings
    $passwordHash = dotnet run update-admin-password-silent $adminSettings.Password
    if ($LASTEXITCODE -ne 0) { throw "Failed to generate password hash" }

    # 3. Remove existing database
    if (Test-Path "Data/app.db") {
        Write-Host "Removing existing database..."
        Remove-Item "Data/app.db" -Force
    }

    # 4. Apply migrations
    Write-Host "Applying database migrations..."
    dotnet ef database update
    if ($LASTEXITCODE -ne 0) { throw "Failed to apply migrations" }

    # 5. Process SQL template
    Write-Host "Processing SQL template..."
    $sql = Get-Content "seed-roles-and-admin.sql" -Raw
    $sql = $sql.Replace("@ADMIN_USERNAME@", $adminSettings.Username)
    $sql = $sql.Replace("@ADMIN_USERNAME_UPPER@", $adminSettings.Username.ToUpper())
    $sql = $sql.Replace("@PASSWORD_HASH@", $passwordHash)
    $sql | Set-Content "seed-roles-and-admin.processed.sql"

    # 6. Apply the SQL
    Write-Host "Seeding admin user and roles..."
    Get-Content "seed-roles-and-admin.processed.sql" | sqlite3 "Data/app.db"
    if ($LASTEXITCODE -ne 0) { throw "Failed to seed database" }

    # 7. Clean up
    Remove-Item "seed-roles-and-admin.processed.sql" -Force

    Write-Host "`nDatabase setup complete!"
    Write-Host "You can now log in with:"
    Write-Host "Username: $($adminSettings.Username)"
    Write-Host "Password: [configured in appsettings.json]"

} catch {
    Write-Host "Error: $_" -ForegroundColor Red
    exit 1
}
