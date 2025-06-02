#!/bin/bash

# Ensure we're in the project directory
cd "$(dirname "$0")"

# Make sure all required roles exist
echo "Ensuring all roles exist..."
./ensure-roles.sh

# Reset admin password using the integrated functionality
echo "Resetting admin password..."
dotnet run update-admin-password
