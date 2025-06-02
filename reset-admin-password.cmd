@echo off
setlocal EnableDelayedExpansion

REM Define the path to the PasswordHasher project
set "PASSWORDHASHER_PATH=..\PasswordHasher"

echo Resetting admin password from appsettings.json...

REM Build PasswordHasher tool
echo Building PasswordHasher tool...
dotnet build %PASSWORDHASHER_PATH%\PasswordHasher.csproj --configuration Release
if errorlevel 1 (
    echo Failed to build PasswordHasher tool
    exit /b 1
)

REM Get password hash
echo Generating password hash...
for /f "usebackq delims=" %%h in (`dotnet %PASSWORDHASHER_PATH%\bin\Release\net9.0\PasswordHasher.dll`) do set PASSWORD_HASH=%%h

if not defined PASSWORD_HASH (
    echo Failed to generate password hash
    exit /b 1
)

REM Update admin password in database
echo Updating admin password in database...
echo UPDATE AspNetUsers SET PasswordHash = '%PASSWORD_HASH%' WHERE NormalizedUserName = 'ADMIN'; | sqlite3 Data\app.db

if errorlevel 1 (
    echo Failed to update password in database
    exit /b 1
) else (
    echo Admin password has been reset successfully!
    echo You can now log in with the credentials specified in appsettings.json
)
