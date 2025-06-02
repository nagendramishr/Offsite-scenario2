#!/bin/bash

# Ensure we're in the project directory
cd "$(dirname "$0")"

# Check if the database exists
if [ ! -f "Data/app.db" ]; then
    echo "Database file not found. Running migrations first..."
    dotnet ef database update
fi

# Run the seed script
echo "Seeding admin user..."
sqlite3 Data/app.db < seed-admin.sql

echo "Done! You can now log in with:"
echo "Username: admin@ticketing.local"
echo "Password: Admin@123456"
