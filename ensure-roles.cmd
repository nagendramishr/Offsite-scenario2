@echo off
setlocal enabledelayedexpansion

echo Ensuring roles exist in the database...

REM Verify that the EndUser role exists
echo Checking if EndUser role exists...
for /f "tokens=*" %%a in ('sqlite3 Data\app.db "SELECT COUNT(*) FROM AspNetRoles WHERE NormalizedName = 'ENDUSER'"') do set ROLE_EXISTS=%%a

if "%ROLE_EXISTS%"=="0" (
    echo EndUser role does not exist. Creating it...
    echo INSERT INTO AspNetRoles (Id, Name, NormalizedName, ConcurrencyStamp) VALUES ('3E7E8A8A-9037-5F34-C32E-D37E1EF1E985', 'EndUser', 'ENDUSER', '6C159DDC-3E66-5160-B91A-GEA12B0C4680'); | sqlite3 Data\app.db
    if errorlevel 1 (
        echo Failed to create EndUser role.
        exit /b 1
    ) else (
        echo EndUser role created successfully!
    )
) else (
    echo EndUser role already exists.
)

REM Verify that the SupportAgent role exists
echo Checking if SupportAgent role exists...
for /f "tokens=*" %%a in ('sqlite3 Data\app.db "SELECT COUNT(*) FROM AspNetRoles WHERE NormalizedName = 'SUPPORTAGENT'"') do set ROLE_EXISTS=%%a

if "%ROLE_EXISTS%"=="0" (
    echo SupportAgent role does not exist. Creating it...
    echo INSERT INTO AspNetRoles (Id, Name, NormalizedName, ConcurrencyStamp) VALUES ('2C5E8A8A-2337-4F34-B32E-C37E1EF1E565', 'SupportAgent', 'SUPPORTAGENT', '5B049DDC-2E55-4050-A81A-FDA12B0C3579'); | sqlite3 Data\app.db
    if errorlevel 1 (
        echo Failed to create SupportAgent role.
        exit /b 1
    ) else (
        echo SupportAgent role created successfully!
    )
) else (
    echo SupportAgent role already exists.
)

REM Verify that the Admin role exists
echo Checking if Admin role exists...
for /f "tokens=*" %%a in ('sqlite3 Data\app.db "SELECT COUNT(*) FROM AspNetRoles WHERE NormalizedName = 'ADMIN'"') do set ROLE_EXISTS=%%a

if "%ROLE_EXISTS%"=="0" (
    echo Admin role does not exist. Creating it...
    echo INSERT INTO AspNetRoles (Id, Name, NormalizedName, ConcurrencyStamp) VALUES ('1D25F9AA-B1DD-4E3D-AFD6-8E0B6B0E46A8', 'Admin', 'ADMIN', '65E7A856-5D17-471A-9432-151C86ECAFBC'); | sqlite3 Data\app.db
    if errorlevel 1 (
        echo Failed to create Admin role.
        exit /b 1
    ) else (
        echo Admin role created successfully!
    )
) else (
    echo Admin role already exists.
)

echo Role verification complete!
