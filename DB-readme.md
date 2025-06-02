# Database Setup

## Prerequisites
- .NET 9.0 SDK
- SQLite (included in .NET SDK)

## Initial Setup
1. The database file is located at `/Data/app.db`
2. Database migrations are already included in `/Data/Migrations/`

## Setting Up Fresh Database
1. Open a terminal in the project root directory
2. Run the following commands:
```bash
# Delete existing database (if any)
rm Data/app.db

# Apply migrations
dotnet ef database update

# Optional: Create an admin user
# You can register normally and then use the SQL command below to make the user an admin
```

## Creating the Admin User

There are two ways to create the admin user:

### 1. Using the Seed Script (Recommended)
We provide a script that creates an admin user with predefined credentials:

1. Make sure you're in the project directory
2. Run the seed script:
```bash
# On Linux/MacOS
chmod +x seed-admin.sh
./seed-admin.sh

# On Windows (WSL)
sqlite3 Data/app.db < seed-admin.sql
```

This will create an admin user with:
- Username: admin@ticketing.local
- Password: Admin@123456
- Role: Admin

### 2. Manual Role Assignment
If you prefer to create your own admin:
1. Register a new user through the application
2. Open SQLite command line:
```bash
sqlite3 Data/app.db
```
3. Run these SQL commands:
```sql
-- First, ensure the Admin role exists
INSERT OR IGNORE INTO AspNetRoles (Id, Name, NormalizedName, ConcurrencyStamp)
VALUES (lower(hex(randomblob(16))), 'Admin', 'ADMIN', lower(hex(randomblob(16))));

-- Then, assign the role to your user (replace 'your-username' with actual username)
INSERT INTO AspNetUserRoles (UserId, RoleId)
SELECT u.Id, r.Id
FROM AspNetUsers u
CROSS JOIN AspNetRoles r
WHERE u.UserName = 'your-username'
AND r.Name = 'Admin';
```

## Database Schema
- Uses ASP.NET Core Identity schema for user management
- Custom tables:
  - AspNetUsers (Identity)
  - AspNetRoles (Identity)
  - AspNetUserRoles (Identity)
  - Tickets (Application data)

## Connection String
The connection string is configured in `appsettings.json`:
```json
{
  "ConnectionStrings": {
    "DefaultConnection": "DataSource=Data\\app.db;Cache=Shared"
  }
}
```

## Backup and Restore
To backup the database:
```bash
cp Data/app.db Data/app.db.backup
```

To restore from backup:
```bash
cp Data/app.db.backup Data/app.db
```
