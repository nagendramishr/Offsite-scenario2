-- This script sets up the initial roles and creates an admin user
-- Password is configured in appsettings.json (defaults to ChangeMe123!)

-- 1. Insert Roles
INSERT OR IGNORE INTO AspNetRoles (Id, Name, NormalizedName, ConcurrencyStamp)
VALUES 
    -- Admin Role
    ('1D25F9AA-B1DD-4E3D-AFD6-8E0B6B0E46A8', 'Admin', 'ADMIN', '65E7A856-5D17-471A-9432-151C86ECAFBC'),
    -- Support Agent Role
    ('2C5E8A8A-2337-4F34-B32E-C37E1EF1E565', 'SupportAgent', 'SUPPORTAGENT', '5B049DDC-2E55-4050-A81A-FDA12B0C3579'),
    -- End User Role
    ('3E7E8A8A-9037-5F34-C32E-D37E1EF1E985', 'EndUser', 'ENDUSER', '6C159DDC-3E66-5160-B91A-GEA12B0C4680');

-- 2. Create Admin User
INSERT OR IGNORE INTO AspNetUsers (
    Id,
    UserName,
    NormalizedUserName,
    Email,
    NormalizedEmail,
    EmailConfirmed,
    PasswordHash,
    SecurityStamp,
    ConcurrencyStamp,
    PhoneNumberConfirmed,
    TwoFactorEnabled,
    LockoutEnabled,
    AccessFailedCount
)
VALUES (    'B3731D2A-4B8E-4E3A-9D6A-D7008B6508DE',
    '@ADMIN_USERNAME@',
    '@ADMIN_USERNAME_UPPER@',
    '@ADMIN_USERNAME@',
    '@ADMIN_USERNAME_UPPER@',
    1, -- EmailConfirmed
    '@PASSWORD_HASH@', -- Hash generated from appsettings.json password
    'YYDARS3BVNMSWMV6XLCGH2JFNKCD2HLX',
    'f4242e39-d757-4139-a147-129aaee985dd',
    0, -- PhoneNumberConfirmed
    0, -- TwoFactorEnabled
    1, -- LockoutEnabled
    0  -- AccessFailedCount
);

-- 3. Assign Admin Role to Admin User
INSERT OR IGNORE INTO AspNetUserRoles (UserId, RoleId)
VALUES (
    'B3731D2A-4B8E-4E3A-9D6A-D7008B6508DE', -- Admin User Id
    '1D25F9AA-B1DD-4E3D-AFD6-8E0B6B0E46A8'  -- Admin Role Id
);
