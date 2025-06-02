# Database Setup Instructions

## Prerequisites
- .NET 9.0 SDK
- SQLite (included with .NET SDK)
- Entity Framework Core tools

## Quick Setup

1. Open a terminal in the project root directory
2. Run the setup script:
   ```bash
   # Windows (WSL)
   ./setup-database.sh

   # Linux/MacOS
   chmod +x setup-database.sh
   ./setup-database.sh
   ```

This will:
- Remove any existing database
- Apply all migrations
- Create the required roles (Admin, SupportAgent, EndUser)
- Create an admin user

## Default Admin Credentials
- Username: admin@ticketing.local
- Password: Admin@123456

## Manual Setup Steps
If you prefer to set up manually:

1. Install EF Core tools:
   ```bash
   dotnet tool install --global dotnet-ef
   ```

2. Apply migrations:
   ```bash
   dotnet ef database update
   ```

3. Seed the database:
   ```bash
   sqlite3 Data/app.db < seed-roles-and-admin.sql
   ```

## Database Schema
The database includes the following tables:
- ASP.NET Identity tables for authentication:
  - AspNetUsers
  - AspNetRoles
  - AspNetUserRoles
  - AspNetUserClaims
  - AspNetRoleClaims
  - AspNetUserLogins
  - AspNetUserTokens
- Application tables for ticket management:
  - Tickets
  - TicketComments
  - TicketAttachments
  - TicketAuditLogs

## Backup and Restore
To backup the database:
```bash
cp Data/app.db Data/app.db.backup
```

To restore from backup:
```bash
cp Data/app.db.backup Data/app.db
```

## Troubleshooting

### Common Issues

1. **Database file not found**
   - Make sure you're in the project root directory
   - Check if Data/app.db exists
   - Run migrations if the file is missing

2. **Migration failed**
   - Delete the database file and try again
   - Check if any pending migrations exist
   - Verify the connection string in appsettings.json

3. **Cannot login as admin**
   - Verify the database was seeded properly
   - Check the roles table for admin role
   - Check user-role assignments
   - Clear browser cookies and try again
