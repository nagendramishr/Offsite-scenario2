#!/bin/bash

# Ensure we're in the project directory
cd "$(dirname "$0")"

echo "Ensuring roles exist in the database..."

# Verify that the EndUser role exists
echo "Checking if EndUser role exists..."
ROLE_EXISTS=$(sqlite3 Data/app.db "SELECT COUNT(*) FROM AspNetRoles WHERE NormalizedName = 'ENDUSER'")

if [ "$ROLE_EXISTS" -eq "0" ]; then
    echo "EndUser role does not exist. Creating it..."
    sqlite3 Data/app.db << EOF
INSERT INTO AspNetRoles (Id, Name, NormalizedName, ConcurrencyStamp)
VALUES ('3E7E8A8A-9037-5F34-C32E-D37E1EF1E985', 'EndUser', 'ENDUSER', '6C159DDC-3E66-5160-B91A-GEA12B0C4680');
EOF
    if [ $? -eq 0 ]; then
        echo "EndUser role created successfully!"
    else
        echo "Failed to create EndUser role."
        exit 1
    fi
else
    echo "EndUser role already exists."
fi

# Verify that the SupportAgent role exists
echo "Checking if SupportAgent role exists..."
ROLE_EXISTS=$(sqlite3 Data/app.db "SELECT COUNT(*) FROM AspNetRoles WHERE NormalizedName = 'SUPPORTAGENT'")

if [ "$ROLE_EXISTS" -eq "0" ]; then
    echo "SupportAgent role does not exist. Creating it..."
    sqlite3 Data/app.db << EOF
INSERT INTO AspNetRoles (Id, Name, NormalizedName, ConcurrencyStamp)
VALUES ('2C5E8A8A-2337-4F34-B32E-C37E1EF1E565', 'SupportAgent', 'SUPPORTAGENT', '5B049DDC-2E55-4050-A81A-FDA12B0C3579');
EOF
    if [ $? -eq 0 ]; then
        echo "SupportAgent role created successfully!"
    else
        echo "Failed to create SupportAgent role."
        exit 1
    fi
else
    echo "SupportAgent role already exists."
fi

# Verify that the Admin role exists
echo "Checking if Admin role exists..."
ROLE_EXISTS=$(sqlite3 Data/app.db "SELECT COUNT(*) FROM AspNetRoles WHERE NormalizedName = 'ADMIN'")

if [ "$ROLE_EXISTS" -eq "0" ]; then
    echo "Admin role does not exist. Creating it..."
    sqlite3 Data/app.db << EOF
INSERT INTO AspNetRoles (Id, Name, NormalizedName, ConcurrencyStamp)
VALUES ('1D25F9AA-B1DD-4E3D-AFD6-8E0B6B0E46A8', 'Admin', 'ADMIN', '65E7A856-5D17-471A-9432-151C86ECAFBC');
EOF
    if [ $? -eq 0 ]; then
        echo "Admin role created successfully!"
    else
        echo "Failed to create Admin role."
        exit 1
    fi
else
    echo "Admin role already exists."
fi

echo "Role verification complete!"
