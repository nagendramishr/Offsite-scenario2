#!/bin/bash

# Ensure we're in the project directory
cd "$(dirname "$0")"

# Define the path to the PasswordHasher project
PASSWORDHASHER_PATH="../PasswordHasher"

echo "Resetting admin password from appsettings.json..."

# Build PasswordHasher tool
echo "Building PasswordHasher tool..."
dotnet build ${PASSWORDHASHER_PATH}/PasswordHasher.csproj --configuration Release

# Get password hash
echo "Generating password hash..."
PASSWORD_HASH=$(dotnet ${PASSWORDHASHER_PATH}/bin/Release/net9.0/PasswordHasher.dll)

if [ $? -ne 0 ]; then
    echo "Failed to generate password hash"
    exit 1
fi

# Update admin password in database
echo "Updating admin password in database..."
sqlite3 Data/app.db << EOF
UPDATE AspNetUsers 
SET PasswordHash = '$PASSWORD_HASH'
WHERE NormalizedUserName = 'ADMIN';
EOF

if [ $? -eq 0 ]; then
    echo "Admin password has been reset successfully!"
    echo "You can now log in with the credentials specified in appsettings.json"
else
    echo "Failed to update password in database"
    exit 1
fi
