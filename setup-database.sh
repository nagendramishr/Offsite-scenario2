#!/bin/bash

# Ensure we're in the project directory
cd "$(dirname "$0")"

echo "Setting up the ticketing system database..."

# Function to clean build artifacts
clean_build_artifacts() {
    echo "Cleaning build artifacts..."
    rm -rf obj/* bin/* 2>/dev/null
    dotnet clean --configuration Release >/dev/null 2>&1
}

# Function to build projects
build_projects() {
    echo "Building projects..."
    # Build main project
    dotnet build --configuration Release
    if [ $? -ne 0 ]; then
        echo "Failed to build main project"
        exit 1
    fi
}

# Check for required tools
if ! command -v sqlite3 &> /dev/null; then
    echo "sqlite3 command not found. Installing sqlite3..."
    sudo apt-get update && sudo apt-get install -y sqlite3
fi

# Clean and rebuild
clean_build_artifacts
build_projects

# Read admin credentials from appsettings.json
if ! command -v jq &> /dev/null; then
    echo "jq command not found. Using default values..."
    ADMIN_USERNAME="admin"
    ADMIN_PASSWORD="ChangeMe123!"
else
    ADMIN_USERNAME=$(jq -r '.AdminSetup.Username // "admin"' appsettings.json)
    ADMIN_PASSWORD=$(jq -r '.AdminSetup.Password // "ChangeMe123!"' appsettings.json)
fi

# Generate password hash
echo "Generating password hash..."
PASSWORD_HASH=$(dotnet run update-admin-password-silent "$ADMIN_PASSWORD")

# Remove existing database if it exists
if [ -f "Data/app.db" ]; then
    echo "Removing existing database..."
    rm Data/app.db
fi

# Apply migrations
echo "Applying database migrations..."
dotnet ef database update --configuration Release

# Process SQL template
echo "Processing SQL template..."
ADMIN_USERNAME_UPPER=$(echo "$ADMIN_USERNAME" | tr "[:lower:]" "[:upper:]")
sed -e "s/@ADMIN_USERNAME@/$ADMIN_USERNAME/g" \
    -e "s/@ADMIN_USERNAME_UPPER@/$ADMIN_USERNAME_UPPER/g" \
    -e "s#@PASSWORD_HASH@#$PASSWORD_HASH#g" \
    seed-roles-and-admin.sql > seed-roles-and-admin.processed.sql

# Seed the database
echo "Seeding admin user and roles..."
sqlite3 Data/app.db < seed-roles-and-admin.processed.sql

# Clean up
rm seed-roles-and-admin.processed.sql

echo -e "\nDatabase setup complete!"
echo "You can now log in with:"
echo "Username: $ADMIN_USERNAME"
echo "Password: [configured in appsettings.json]"
