-- This script creates an admin user with the following credentials:
-- Username: admin@ticketing.local
-- Password: Admin@123456
-- IMPORTANT: Run this only after applying all migrations

-- 1. Insert Admin Role (if not exists)
INSERT OR IGNORE INTO AspNetRoles (Id, Name, NormalizedName, ConcurrencyStamp)
VALUES (
    '1D25F9AA-B1DD-4E3D-AFD6-8E0B6B0E46A8',
    'Admin',
    'ADMIN',
    '65E7A856-5D17-471A-9432-151C86ECAFBC'
);

-- 2. Create Admin User
-- Password hash is for 'Admin@123456' - created using ASP.NET Core Identity password hasher
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
VALUES (
    'B3731D2A-4B8E-4E3A-9D6A-D7008B6508DE',
    'admin@ticketing.local',
    'ADMIN@TICKETING.LOCAL',
    'admin@ticketing.local',
    'ADMIN@TICKETING.LOCAL',
    1, -- EmailConfirmed
    'AQAAAAIAAYagAAAAEJOFmY3UeN5PS2YcNNoC+jt1cCKXLp/Gu0MAIm56RLpeHi1DZwXZB+3KkkP8SQkELg==', -- Hash for Admin@123456
    'YYDARS3BVNMSWMV6XLCGH2JFNKCD2HLX',
    'f4242e39-d757-4139-a147-129aaee985dd',
    0, -- PhoneNumberConfirmed
    0, -- TwoFactorEnabled
    1, -- LockoutEnabled
    0  -- AccessFailedCount
);

-- 3. Assign Admin Role to User
INSERT OR IGNORE INTO AspNetUserRoles (UserId, RoleId)
VALUES (
    'B3731D2A-4B8E-4E3A-9D6A-D7008B6508DE', -- User Id
    '1D25F9AA-B1DD-4E3D-AFD6-8E0B6B0E46A8'  -- Role Id
);

-- 4. Add Support Agent Role
INSERT OR IGNORE INTO AspNetRoles (Id, Name, NormalizedName, ConcurrencyStamp)
VALUES (
    '2C5E8A8A-2337-4F34-B32E-C37E1EF1E565',
    'SupportAgent',
    'SUPPORTAGENT',
    '5B049DDC-2E55-4050-A81A-FDA12B0C3579'
);

-- 5. Add End User Role
INSERT OR IGNORE INTO AspNetRoles (Id, Name, NormalizedName, ConcurrencyStamp)
VALUES (
    '3E7E8A8A-9037-5F34-C32E-D37E1EF1E985',
    'EndUser',
    'ENDUSER',
    '6C159DDC-3E66-5160-B91A-GEA12B0C4680'
);
