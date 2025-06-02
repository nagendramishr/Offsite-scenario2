# Database Setup for Ticketing System

## Prerequisites
- .NET 9 SDK
- SQLite3 (for local inspection, optional)

## Quick Setup (Recommended)

1. **Apply database migrations:**

   ```sh
   dotnet ef database update
   ```

2. **Ensure admin user and roles exist:**

   ```sh
   dotnet run update-admin-password
   ```
   - This will create or update the admin user and all required roles using the credentials in `appsettings.json`.

3. **Login**
   - Username: as set in `appsettings.json` (`AdminSetup:Username`)
   - Password: as set in `appsettings.json` (`AdminSetup:Password`)

## Notes
- You do **not** need to run any shell scripts or SQL files for seeding users or roles. All logic is handled in C# via the steps above.
- If you delete `Data/app.db`, simply repeat the steps above to fully re-initialize the database.
- If you change the admin password or username in `appsettings.json`, re-run `dotnet run update-admin-password` to update the credentials.

## Legacy Scripts
- The following scripts and SQL files are now obsolete and can be deleted or ignored:
  - `setup-database.sh`, `setup-database.ps1`, `setup-database.cmd`
  - `seed-roles-and-admin.sql` and similar seed files
  - `ensure-roles.*`, `reset-admin-password.*`, and any other manual seeding scripts

## Troubleshooting
- If you see errors about missing NOT NULL columns, ensure you are using the latest migrations and codebase.
- For schema changes, add a new migration and re-run the steps above.

---

_Last updated: June 2, 2025_
