@echo off
setlocal enabledelayedexpansion

echo Setting up the ticketing system database...

REM Build the main project
echo Building main project...
dotnet build --configuration Release
if errorlevel 1 (
    echo Failed to build main project
    exit /b 1
)

REM Get admin credentials from appsettings.json
REM Default to hardcoded values if powershell is not available
set ADMIN_USERNAME=admin
set ADMIN_PASSWORD=ChangeMe123!
powershell -Command "(Get-Content appsettings.json | ConvertFrom-Json).AdminSetup.Username" > temp.txt 2>nul
if !errorlevel! equ 0 (
    set /p ADMIN_USERNAME=<temp.txt
    del temp.txt
)
powershell -Command "(Get-Content appsettings.json | ConvertFrom-Json).AdminSetup.Password" > temp.txt 2>nul
if !errorlevel! equ 0 (
    set /p ADMIN_PASSWORD=<temp.txt
    del temp.txt
)

REM Generate password hash
echo Generating password hash...
for /f "tokens=*" %%a in ('dotnet run update-admin-password-silent "%ADMIN_PASSWORD%"') do set PASSWORD_HASH=%%a

REM Build main project
echo Building main project...
dotnet build --configuration Release
if errorlevel 1 (
    echo Failed to build main project
    exit /b 1
)

REM Remove existing database if it exists
if exist "Data\app.db" (
    echo Removing existing database...
    del "Data\app.db"
)

REM Apply migrations
echo Applying database migrations...
dotnet tool install --global dotnet-ef 2>nul
dotnet ef database update --configuration Release
if errorlevel 1 (
    echo Failed to apply migrations
    exit /b 1
)

REM Process SQL template
echo Processing SQL template...
set "ADMIN_USERNAME_UPPER=!ADMIN_USERNAME!"
powershell -Command "$env:ADMIN_USERNAME_UPPER = $env:ADMIN_USERNAME.ToUpper()"

REM Create processed SQL file
powershell -Command "(Get-Content seed-roles-and-admin.sql) -replace '@ADMIN_USERNAME@','%ADMIN_USERNAME%' -replace '@ADMIN_USERNAME_UPPER@','!ADMIN_USERNAME_UPPER!' -replace '@PASSWORD_HASH@','%PASSWORD_HASH%' | Set-Content seed-roles-and-admin.processed.sql"

REM Seed the database
echo Seeding admin user and roles...
dotnet ef database update --configuration Release

echo Database setup complete!
echo You can now log in with:
echo Username: %ADMIN_USERNAME%
echo Password: [configured in appsettings.json]

REM Clean up
del seed-roles-and-admin.processed.sql 2>nul

endlocal
