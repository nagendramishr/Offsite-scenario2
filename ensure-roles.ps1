# Ensure roles exist in the database
Write-Host "Ensuring roles exist in the database..."

# Function to check and create role if needed
function Ensure-Role {
    param (
        [string]$RoleName,
        [string]$NormalizedRoleName,
        [string]$RoleId,
        [string]$ConcurrencyStamp
    )

    Write-Host "Checking if $RoleName role exists..."
    $exists = sqlite3 "Data/app.db" "SELECT COUNT(*) FROM AspNetRoles WHERE NormalizedName = '$NormalizedRoleName'"
    
    if ($exists -eq "0") {
        Write-Host "$RoleName role does not exist. Creating it..."
        $query = "INSERT INTO AspNetRoles (Id, Name, NormalizedName, ConcurrencyStamp) VALUES ('$RoleId', '$RoleName', '$NormalizedRoleName', '$ConcurrencyStamp');"
        echo $query | sqlite3 "Data/app.db"
        
        if ($LASTEXITCODE -eq 0) {
            Write-Host "$RoleName role created successfully!"
        } else {
            Write-Host "Failed to create $RoleName role."
            exit 1
        }
    } else {
        Write-Host "$RoleName role already exists."
    }
}

# Ensure EndUser role
Ensure-Role -RoleName "EndUser" -NormalizedRoleName "ENDUSER" -RoleId "3E7E8A8A-9037-5F34-C32E-D37E1EF1E985" -ConcurrencyStamp "6C159DDC-3E66-5160-B91A-GEA12B0C4680"

# Ensure SupportAgent role
Ensure-Role -RoleName "SupportAgent" -NormalizedRoleName "SUPPORTAGENT" -RoleId "2C5E8A8A-2337-4F34-B32E-C37E1EF1E565" -ConcurrencyStamp "5B049DDC-2E55-4050-A81A-FDA12B0C3579"

# Ensure Admin role
Ensure-Role -RoleName "Admin" -NormalizedRoleName "ADMIN" -RoleId "1D25F9AA-B1DD-4E3D-AFD6-8E0B6B0E46A8" -ConcurrencyStamp "65E7A856-5D17-471A-9432-151C86ECAFBC"

Write-Host "Role verification complete!"
