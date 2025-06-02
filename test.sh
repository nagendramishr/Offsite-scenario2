#!/bin/bash
# Reset admin password
echo "Resetting admin password to 'Admin123!'"

# Set a simple known password hash for AQAAAAIAAYagAAAAE format (ASP.NET Core Identity v3)
NEW_PASSWORD_HASH="AQAAAAIAAYagAAAAELBm+HePxTRc3YAzU5KFaz7jG7kALQQxVTS8/ZbVLbiH9HLmVvS7TJUJfvEGiwdShA=="

sqlite3 Data/app.db "UPDATE AspNetUsers SET PasswordHash = '$NEW_PASSWORD_HASH' WHERE UserName = 'admin';"
if [ $? -ne 0 ]; then
    echo "Failed to update password in database"
    exit 1
fi
echo "Admin password reset successfully to 'Admin123!'"
