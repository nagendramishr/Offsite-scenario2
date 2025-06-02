@echo off
REM Make sure all required roles exist
echo Ensuring all roles exist...
call ensure-roles.cmd

REM Reset admin password using the integrated functionality
echo Resetting admin password...
dotnet run update-admin-password
pause
