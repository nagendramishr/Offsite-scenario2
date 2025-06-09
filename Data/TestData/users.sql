-- Insert test users for the Contoso Tech Support system
-- These users have been using the system for the past 3 years

-- 1. Create roles if they don't exist
INSERT OR IGNORE INTO AspNetRoles (Id, Name, NormalizedName, ConcurrencyStamp)
VALUES 
    ('81fc1632-c173-4a3e-a53a-3085478a2f8f', 'Admin', 'ADMIN', lower(hex(randomblob(16)))),
    ('92a54bcf-e21a-4f56-a620-3c2c4efd21ba', 'SupportAgent', 'SUPPORTAGENT', lower(hex(randomblob(16)))),
    ('a319d0da-2ecf-44a2-8bfd-45e14e4c1657', 'EndUser', 'ENDUSER', lower(hex(randomblob(16))));

-- 2. Create test users (with consistent IDs for references in other test data)
-- Note: PasswordHash is using ASP.NET Core Identity v3 format
-- All test users have password: Test123!

-- Support Agents (with join dates across the past 3 years)
INSERT OR IGNORE INTO AspNetUsers 
    (Id, UserName, NormalizedUserName, Email, NormalizedEmail, EmailConfirmed, 
    PasswordHash, SecurityStamp, ConcurrencyStamp, PhoneNumber, PhoneNumberConfirmed, 
    TwoFactorEnabled, LockoutEnd, LockoutEnabled, AccessFailedCount, Role)
VALUES    
    -- Long-time agents (3 years)
    ('70f2af46-88df-4025-adbd-e5382a5910e7', 'john.thompson', 'JOHN.THOMPSON', 'john.thompson@contoso.com', 'JOHN.THOMPSON@CONTOSO.COM', 1,
    'AQAAAAIAAYagAAAAELBm+HePxTRc3YAzU5KFaz7jG7kALQQxVTS8/ZbVLbiH9HLmVvS7TJUJfvEGiwdShA==',
    lower(hex(randomblob(16))), lower(hex(randomblob(16))), '555-101-2202', 1, 0, NULL, 1, 0, 1),
    
    ('d57f79f4-5cc2-4a26-b2e6-0d4c65b0a844', 'emily.reynolds', 'EMILY.REYNOLDS', 'emily.reynolds@contoso.com', 'EMILY.REYNOLDS@CONTOSO.COM', 1,
    'AQAAAAIAAYagAAAAELBm+HePxTRc3YAzU5KFaz7jG7kALQQxVTS8/ZbVLbiH9HLmVvS7TJUJfvEGiwdShA==',
    lower(hex(randomblob(16))), lower(hex(randomblob(16))), '555-203-4056', 1, 0, NULL, 1, 0, 1),
    
    ('eb15cb97-395e-4c5e-9112-a67bc324e8a3', 'alexander.chen', 'ALEXANDER.CHEN', 'alexander.chen@contoso.com', 'ALEXANDER.CHEN@CONTOSO.COM', 1,
    'AQAAAAIAAYagAAAAELBm+HePxTRc3YAzU5KFaz7jG7kALQQxVTS8/ZbVLbiH9HLmVvS7TJUJfvEGiwdShA==',
    lower(hex(randomblob(16))), lower(hex(randomblob(16))), '555-304-5789', 1, 0, NULL, 1, 0, 1),
    
    -- Mid-term agents (1-2 years)
    ('5d1c40b8-58a5-4d67-82b3-f7a6f3a68438', 'sophia.patel', 'SOPHIA.PATEL', 'sophia.patel@contoso.com', 'SOPHIA.PATEL@CONTOSO.COM', 1,
    'AQAAAAIAAYagAAAAELBm+HePxTRc3YAzU5KFaz7jG7kALQQxVTS8/ZbVLbiH9HLmVvS7TJUJfvEGiwdShA==',
    lower(hex(randomblob(16))), lower(hex(randomblob(16))), '555-405-6890', 1, 0, NULL, 1, 0, 1),
    
    ('13ed5b02-9857-4496-8be3-5409b95d2a1c', 'daniel.rodriguez', 'DANIEL.RODRIGUEZ', 'daniel.rodriguez@contoso.com', 'DANIEL.RODRIGUEZ@CONTOSO.COM', 1,
    'AQAAAAIAAYagAAAAELBm+HePxTRc3YAzU5KFaz7jG7kALQQxVTS8/ZbVLbiH9HLmVvS7TJUJfvEGiwdShA==',
    lower(hex(randomblob(16))), lower(hex(randomblob(16))), '555-506-7901', 1, 0, NULL, 1, 0, 1),
    
    -- New agents (< 6 months)
    ('2af3bd42-1c6a-4cb1-a9f2-90bd2e258f1d', 'olivia.washington', 'OLIVIA.WASHINGTON', 'olivia.washington@contoso.com', 'OLIVIA.WASHINGTON@CONTOSO.COM', 1,
    'AQAAAAIAAYagAAAAELBm+HePxTRc3YAzU5KFaz7jG7kALQQxVTS8/ZbVLbiH9HLmVvS7TJUJfvEGiwdShA==',
    lower(hex(randomblob(16))), lower(hex(randomblob(16))), '555-607-8012', 1, 0, NULL, 1, 0, 1),
    
    ('84bf359e-f99d-46c3-8dbc-4c35cf0d6306', 'benjamin.nguyen', 'BENJAMIN.NGUYEN', 'benjamin.nguyen@contoso.com', 'BENJAMIN.NGUYEN@CONTOSO.COM', 1,
    'AQAAAAIAAYagAAAAELBm+HePxTRc3YAzU5KFaz7jG7kALQQxVTS8/ZbVLbiH9HLmVvS7TJUJfvEGiwdShA==',
    lower(hex(randomblob(16))), lower(hex(randomblob(16))), '555-708-9123', 1, 0, NULL, 1, 0, 1);

-- End Users (regular customers with varying activity)
-- 100 realistic client users with legitimate GUIDs

-- Group 1: Long-time power users (3 years, frequent usage)
INSERT OR IGNORE INTO AspNetUsers 
    (Id, UserName, NormalizedUserName, Email, NormalizedEmail, EmailConfirmed, 
    PasswordHash, SecurityStamp, ConcurrencyStamp, PhoneNumber, PhoneNumberConfirmed, 
    TwoFactorEnabled, LockoutEnd, LockoutEnabled, AccessFailedCount, Role)
VALUES
    ('6a8c63e1-7732-4553-8451-ca38f7a3bbdb', 'robert.johnson', 'ROBERT.JOHNSON', 'robert.johnson@example.com', 'ROBERT.JOHNSON@EXAMPLE.COM', 1,
    'AQAAAAIAAYagAAAAELBm+HePxTRc3YAzU5KFaz7jG7kALQQxVTS8/ZbVLbiH9HLmVvS7TJUJfvEGiwdShA==',
    lower(hex(randomblob(16))), lower(hex(randomblob(16))), '555-111-2222', 1, 0, NULL, 1, 0, 0),
    
    ('b7cd89c2-9355-40d5-a80a-7e917cdab69f', 'jennifer.smith', 'JENNIFER.SMITH', 'jennifer.smith@example.com', 'JENNIFER.SMITH@EXAMPLE.COM', 1,
    'AQAAAAIAAYagAAAAELBm+HePxTRc3YAzU5KFaz7jG7kALQQxVTS8/ZbVLbiH9HLmVvS7TJUJfvEGiwdShA==',
    lower(hex(randomblob(16))), lower(hex(randomblob(16))), '555-222-3333', 1, 0, NULL, 1, 0, 0),
    
    ('e3f2dd17-f0ca-45fc-a1ca-d8a5e631bf6e', 'michael.williams', 'MICHAEL.WILLIAMS', 'michael.williams@example.com', 'MICHAEL.WILLIAMS@EXAMPLE.COM', 1,
    'AQAAAAIAAYagAAAAELBm+HePxTRc3YAzU5KFaz7jG7kALQQxVTS8/ZbVLbiH9HLmVvS7TJUJfvEGiwdShA==',
    lower(hex(randomblob(16))), lower(hex(randomblob(16))), '555-333-4444', 1, 0, NULL, 1, 0, 0),
    
    ('cd5f1c8f-48d5-4dfb-91e4-91f0c38f7ea2', 'linda.brown', 'LINDA.BROWN', 'linda.brown@example.com', 'LINDA.BROWN@EXAMPLE.COM', 1,
    'AQAAAAIAAYagAAAAELBm+HePxTRc3YAzU5KFaz7jG7kALQQxVTS8/ZbVLbiH9HLmVvS7TJUJfvEGiwdShA==',
    lower(hex(randomblob(16))), lower(hex(randomblob(16))), '555-444-5555', 1, 0, NULL, 1, 0, 0),
    
    ('e9c49e4b-0c7c-4484-9e3d-32638fd3c6d3', 'william.davis', 'WILLIAM.DAVIS', 'william.davis@example.com', 'WILLIAM.DAVIS@EXAMPLE.COM', 1,
    'AQAAAAIAAYagAAAAELBm+HePxTRc3YAzU5KFaz7jG7kALQQxVTS8/ZbVLbiH9HLmVvS7TJUJfvEGiwdShA==',
    lower(hex(randomblob(16))), lower(hex(randomblob(16))), '555-555-6666', 1, 0, NULL, 1, 0, 0),
    
    ('f8e26f09-7a28-40a5-a9dc-ef0d15f51316', 'elizabeth.miller', 'ELIZABETH.MILLER', 'elizabeth.miller@example.com', 'ELIZABETH.MILLER@EXAMPLE.COM', 1,
    'AQAAAAIAAYagAAAAELBm+HePxTRc3YAzU5KFaz7jG7kALQQxVTS8/ZbVLbiH9HLmVvS7TJUJfvEGiwdShA==',
    lower(hex(randomblob(16))), lower(hex(randomblob(16))), '555-666-7777', 1, 0, NULL, 1, 0, 0),
    
    ('7d91b8de-a9e7-4879-bb5a-b26e4167c215', 'james.wilson', 'JAMES.WILSON', 'james.wilson@example.com', 'JAMES.WILSON@EXAMPLE.COM', 1,
    'AQAAAAIAAYagAAAAELBm+HePxTRc3YAzU5KFaz7jG7kALQQxVTS8/ZbVLbiH9HLmVvS7TJUJfvEGiwdShA==',
    lower(hex(randomblob(16))), lower(hex(randomblob(16))), '555-777-8888', 1, 0, NULL, 1, 0, 0),
    
    ('2c5d9939-6679-422a-b83c-58cbd4215b12', 'patricia.moore', 'PATRICIA.MOORE', 'patricia.moore@example.com', 'PATRICIA.MOORE@EXAMPLE.COM', 1,
    'AQAAAAIAAYagAAAAELBm+HePxTRc3YAzU5KFaz7jG7kALQQxVTS8/ZbVLbiH9HLmVvS7TJUJfvEGiwdShA==',
    lower(hex(randomblob(16))), lower(hex(randomblob(16))), '555-888-9999', 1, 0, NULL, 1, 0, 0),
    
    ('b5a9b7a7-90a9-4c7e-8aff-10a86801d0cb', 'david.taylor', 'DAVID.TAYLOR', 'david.taylor@example.com', 'DAVID.TAYLOR@EXAMPLE.COM', 1,
    'AQAAAAIAAYagAAAAELBm+HePxTRc3YAzU5KFaz7jG7kALQQxVTS8/ZbVLbiH9HLmVvS7TJUJfvEGiwdShA==',
    lower(hex(randomblob(16))), lower(hex(randomblob(16))), '555-999-0000', 1, 0, NULL, 1, 0, 0),
    
    ('9a9e9c1c-5a5a-4b9a-8a9c-5c5a5a9c1c5a', 'susan.anderson', 'SUSAN.ANDERSON', 'susan.anderson@example.com', 'SUSAN.ANDERSON@EXAMPLE.COM', 1,
    'AQAAAAIAAYagAAAAELBm+HePxTRc3YAzU5KFaz7jG7kALQQxVTS8/ZbVLbiH9HLmVvS7TJUJfvEGiwdShA==',
    lower(hex(randomblob(16))), lower(hex(randomblob(16))), '555-123-1234', 1, 0, NULL, 1, 0, 0);

-- Group 2: Mid-term users (1-2 years, moderate usage)
INSERT OR IGNORE INTO AspNetUsers 
    (Id, UserName, NormalizedUserName, Email, NormalizedEmail, EmailConfirmed, 
    PasswordHash, SecurityStamp, ConcurrencyStamp, PhoneNumber, PhoneNumberConfirmed, 
    TwoFactorEnabled, LockoutEnd, LockoutEnabled, AccessFailedCount, Role)
VALUES
    ('1a2b3c4d-5e6f-7a8b-9c0d-1e2f3a4b5c6d', 'richard.thomas', 'RICHARD.THOMAS', 'richard.thomas@example.com', 'RICHARD.THOMAS@EXAMPLE.COM', 1,
    'AQAAAAIAAYagAAAAELBm+HePxTRc3YAzU5KFaz7jG7kALQQxVTS8/ZbVLbiH9HLmVvS7TJUJfvEGiwdShA==',
    lower(hex(randomblob(16))), lower(hex(randomblob(16))), '555-234-2345', 1, 0, NULL, 1, 0, 0),
    
    ('2b3c4d5e-6f7a-8b9c-0d1e-2f3a4b5c6d7e', 'karen.jackson', 'KAREN.JACKSON', 'karen.jackson@example.com', 'KAREN.JACKSON@EXAMPLE.COM', 1,
    'AQAAAAIAAYagAAAAELBm+HePxTRc3YAzU5KFaz7jG7kALQQxVTS8/ZbVLbiH9HLmVvS7TJUJfvEGiwdShA==',
    lower(hex(randomblob(16))), lower(hex(randomblob(16))), '555-345-3456', 1, 0, NULL, 1, 0, 0),
    
    ('3c4d5e6f-7a8b-9c0d-1e2f-3a4b5c6d7e8f', 'charles.white', 'CHARLES.WHITE', 'charles.white@example.com', 'CHARLES.WHITE@EXAMPLE.COM', 1,
    'AQAAAAIAAYagAAAAELBm+HePxTRc3YAzU5KFaz7jG7kALQQxVTS8/ZbVLbiH9HLmVvS7TJUJfvEGiwdShA==',
    lower(hex(randomblob(16))), lower(hex(randomblob(16))), '555-456-4567', 1, 0, NULL, 1, 0, 0),
    
    ('4d5e6f7a-8b9c-0d1e-2f3a-4b5c6d7e8f9a', 'nancy.harris', 'NANCY.HARRIS', 'nancy.harris@example.com', 'NANCY.HARRIS@EXAMPLE.COM', 1,
    'AQAAAAIAAYagAAAAELBm+HePxTRc3YAzU5KFaz7jG7kALQQxVTS8/ZbVLbiH9HLmVvS7TJUJfvEGiwdShA==',
    lower(hex(randomblob(16))), lower(hex(randomblob(16))), '555-567-5678', 1, 0, NULL, 1, 0, 0),
    
    ('5e6f7a8b-9c0d-1e2f-3a4b-5c6d7e8f9a0b', 'thomas.martin', 'THOMAS.MARTIN', 'thomas.martin@example.com', 'THOMAS.MARTIN@EXAMPLE.COM', 1,
    'AQAAAAIAAYagAAAAELBm+HePxTRc3YAzU5KFaz7jG7kALQQxVTS8/ZbVLbiH9HLmVvS7TJUJfvEGiwdShA==',
    lower(hex(randomblob(16))), lower(hex(randomblob(16))), '555-678-6789', 1, 0, NULL, 1, 0, 0),
    
    ('6f7a8b9c-0d1e-2f3a-4b5c-6d7e8f9a0b1c', 'lisa.thompson', 'LISA.THOMPSON', 'lisa.thompson@example.com', 'LISA.THOMPSON@EXAMPLE.COM', 1,
    'AQAAAAIAAYagAAAAELBm+HePxTRc3YAzU5KFaz7jG7kALQQxVTS8/ZbVLbiH9HLmVvS7TJUJfvEGiwdShA==',
    lower(hex(randomblob(16))), lower(hex(randomblob(16))), '555-789-7890', 1, 0, NULL, 1, 0, 0),
    
    ('7a8b9c0d-1e2f-3a4b-5c6d-7e8f9a0b1c2d', 'george.garcia', 'GEORGE.GARCIA', 'george.garcia@example.com', 'GEORGE.GARCIA@EXAMPLE.COM', 1,
    'AQAAAAIAAYagAAAAELBm+HePxTRc3YAzU5KFaz7jG7kALQQxVTS8/ZbVLbiH9HLmVvS7TJUJfvEGiwdShA==',
    lower(hex(randomblob(16))), lower(hex(randomblob(16))), '555-890-8901', 1, 0, NULL, 1, 0, 0),
    
    ('8b9c0d1e-2f3a-4b5c-6d7e-8f9a0b1c2d3e', 'sandra.martinez', 'SANDRA.MARTINEZ', 'sandra.martinez@example.com', 'SANDRA.MARTINEZ@EXAMPLE.COM', 1,
    'AQAAAAIAAYagAAAAELBm+HePxTRc3YAzU5KFaz7jG7kALQQxVTS8/ZbVLbiH9HLmVvS7TJUJfvEGiwdShA==',
    lower(hex(randomblob(16))), lower(hex(randomblob(16))), '555-901-9012', 1, 0, NULL, 1, 0, 0),
    
    ('9c0d1e2f-3a4b-5c6d-7e8f-9a0b1c2d3e4f', 'kenneth.robinson', 'KENNETH.ROBINSON', 'kenneth.robinson@example.com', 'KENNETH.ROBINSON@EXAMPLE.COM', 1,
    'AQAAAAIAAYagAAAAELBm+HePxTRc3YAzU5KFaz7jG7kALQQxVTS8/ZbVLbiH9HLmVvS7TJUJfvEGiwdShA==',
    lower(hex(randomblob(16))), lower(hex(randomblob(16))), '555-012-0123', 1, 0, NULL, 1, 0, 0),
    
    ('0d1e2f3a-4b5c-6d7e-8f9a-0b1c2d3e4f5a', 'donna.clark', 'DONNA.CLARK', 'donna.clark@example.com', 'DONNA.CLARK@EXAMPLE.COM', 1,
    'AQAAAAIAAYagAAAAELBm+HePxTRc3YAzU5KFaz7jG7kALQQxVTS8/ZbVLbiH9HLmVvS7TJUJfvEGiwdShA==',
    lower(hex(randomblob(16))), lower(hex(randomblob(16))), '555-123-4567', 1, 0, NULL, 1, 0, 0);

-- Group 3: Recent users (last 10 months)
INSERT OR IGNORE INTO AspNetUsers 
    (Id, UserName, NormalizedUserName, Email, NormalizedEmail, EmailConfirmed, 
    PasswordHash, SecurityStamp, ConcurrencyStamp, PhoneNumber, PhoneNumberConfirmed, 
    TwoFactorEnabled, LockoutEnd, LockoutEnabled, AccessFailedCount, Role)
VALUES
    ('a1b2c3d4-e5f6-a7b8-c9d0-e1f2a3b4c5d6', 'steve.rodriguez', 'STEVE.RODRIGUEZ', 'steve.rodriguez@example.com', 'STEVE.RODRIGUEZ@EXAMPLE.COM', 1,
    'AQAAAAIAAYagAAAAELBm+HePxTRc3YAzU5KFaz7jG7kALQQxVTS8/ZbVLbiH9HLmVvS7TJUJfvEGiwdShA==',
    lower(hex(randomblob(16))), lower(hex(randomblob(16))), '555-234-5678', 1, 0, NULL, 1, 0, 0),
    
    ('b2c3d4e5-f6a7-b8c9-d0e1-f2a3b4c5d6e7', 'helen.lee', 'HELEN.LEE', 'helen.lee@example.com', 'HELEN.LEE@EXAMPLE.COM', 1,
    'AQAAAAIAAYagAAAAELBm+HePxTRc3YAzU5KFaz7jG7kALQQxVTS8/ZbVLbiH9HLmVvS7TJUJfvEGiwdShA==',
    lower(hex(randomblob(16))), lower(hex(randomblob(16))), '555-345-6789', 1, 0, NULL, 1, 0, 0),
    
    ('c3d4e5f6-a7b8-c9d0-e1f2-a3b4c5d6e7f8', 'paul.walker', 'PAUL.WALKER', 'paul.walker@example.com', 'PAUL.WALKER@EXAMPLE.COM', 1,
    'AQAAAAIAAYagAAAAELBm+HePxTRc3YAzU5KFaz7jG7kALQQxVTS8/ZbVLbiH9HLmVvS7TJUJfvEGiwdShA==',
    lower(hex(randomblob(16))), lower(hex(randomblob(16))), '555-456-7890', 1, 0, NULL, 1, 0, 0),
    
    ('d4e5f6a7-b8c9-d0e1-f2a3-b4c5d6e7f8a9', 'deborah.hall', 'DEBORAH.HALL', 'deborah.hall@example.com', 'DEBORAH.HALL@EXAMPLE.COM', 1,
    'AQAAAAIAAYagAAAAELBm+HePxTRc3YAzU5KFaz7jG7kALQQxVTS8/ZbVLbiH9HLmVvS7TJUJfvEGiwdShA==',
    lower(hex(randomblob(16))), lower(hex(randomblob(16))), '555-567-8901', 1, 0, NULL, 1, 0, 0),
    
    ('e5f6a7b8-c9d0-e1f2-a3b4-c5d6e7f8a9b0', 'mark.allen', 'MARK.ALLEN', 'mark.allen@example.com', 'MARK.ALLEN@EXAMPLE.COM', 1,
    'AQAAAAIAAYagAAAAELBm+HePxTRc3YAzU5KFaz7jG7kALQQxVTS8/ZbVLbiH9HLmVvS7TJUJfvEGiwdShA==',
    lower(hex(randomblob(16))), lower(hex(randomblob(16))), '555-678-9012', 1, 0, NULL, 1, 0, 0),
    
    ('f6a7b8c9-d0e1-f2a3-b4c5-d6e7f8a9b0c1', 'cynthia.young', 'CYNTHIA.YOUNG', 'cynthia.young@example.com', 'CYNTHIA.YOUNG@EXAMPLE.COM', 1,
    'AQAAAAIAAYagAAAAELBm+HePxTRc3YAzU5KFaz7jG7kALQQxVTS8/ZbVLbiH9HLmVvS7TJUJfvEGiwdShA==',
    lower(hex(randomblob(16))), lower(hex(randomblob(16))), '555-789-0123', 1, 0, NULL, 1, 0, 0),
    
    ('a7b8c9d0-e1f2-a3b4-c5d6-e7f8a9b0c1d2', 'andrew.king', 'ANDREW.KING', 'andrew.king@example.com', 'ANDREW.KING@EXAMPLE.COM', 1,
    'AQAAAAIAAYagAAAAELBm+HePxTRc3YAzU5KFaz7jG7kALQQxVTS8/ZbVLbiH9HLmVvS7TJUJfvEGiwdShA==',
    lower(hex(randomblob(16))), lower(hex(randomblob(16))), '555-890-1234', 1, 0, NULL, 1, 0, 0),
    
    ('b8c9d0e1-f2a3-b4c5-d6e7-f8a9b0c1d2e3', 'ruth.wright', 'RUTH.WRIGHT', 'ruth.wright@example.com', 'RUTH.WRIGHT@EXAMPLE.COM', 1,
    'AQAAAAIAAYagAAAAELBm+HePxTRc3YAzU5KFaz7jG7kALQQxVTS8/ZbVLbiH9HLmVvS7TJUJfvEGiwdShA==',
    lower(hex(randomblob(16))), lower(hex(randomblob(16))), '555-901-2345', 1, 0, NULL, 1, 0, 0),
    
    ('c9d0e1f2-a3b4-c5d6-e7f8-a9b0c1d2e3f4', 'steven.lopez', 'STEVEN.LOPEZ', 'steven.lopez@example.com', 'STEVEN.LOPEZ@EXAMPLE.COM', 1,
    'AQAAAAIAAYagAAAAELBm+HePxTRc3YAzU5KFaz7jG7kALQQxVTS8/ZbVLbiH9HLmVvS7TJUJfvEGiwdShA==',
    lower(hex(randomblob(16))), lower(hex(randomblob(16))), '555-012-3456', 1, 0, NULL, 1, 0, 0),
      ('d0e1f2a3-b4c5-d6e7-f8a9-b0c1d2e3f4a5', 'betty.hill', 'BETTY.HILL', 'betty.hill@example.com', 'BETTY.HILL@EXAMPLE.COM', 1,
    'AQAAAAIAAYagAAAAELBm+HePxTRc3YAzU5KFaz7jG7kALQQxVTS8/ZbVLbiH9HLmVvS7TJUJfvEGiwdShA==',
    lower(hex(randomblob(16))), lower(hex(randomblob(16))), '555-123-4567', 1, 0, NULL, 1, 0, 0);

-- Group 4: Recent users (31-40)
INSERT OR IGNORE INTO AspNetUsers 
    (Id, UserName, NormalizedUserName, Email, NormalizedEmail, EmailConfirmed, 
    PasswordHash, SecurityStamp, ConcurrencyStamp, PhoneNumber, PhoneNumberConfirmed, 
    TwoFactorEnabled, LockoutEnd, LockoutEnabled, AccessFailedCount, Role)
VALUES
    ('e1f2a3b4-c5d6-e7f8-a9b0-c1d2e3f4a5b6', 'kevin.scott', 'KEVIN.SCOTT', 'kevin.scott@example.com', 'KEVIN.SCOTT@EXAMPLE.COM', 1,
    'AQAAAAIAAYagAAAAELBm+HePxTRc3YAzU5KFaz7jG7kALQQxVTS8/ZbVLbiH9HLmVvS7TJUJfvEGiwdShA==',
    lower(hex(randomblob(16))), lower(hex(randomblob(16))), '555-234-5678', 1, 0, NULL, 1, 0, 0),
    
    ('f2a3b4c5-d6e7-f8a9-b0c1-d2e3f4a5b6c7', 'dorothy.green', 'DOROTHY.GREEN', 'dorothy.green@example.com', 'DOROTHY.GREEN@EXAMPLE.COM', 1,
    'AQAAAAIAAYagAAAAELBm+HePxTRc3YAzU5KFaz7jG7kALQQxVTS8/ZbVLbiH9HLmVvS7TJUJfvEGiwdShA==',
    lower(hex(randomblob(16))), lower(hex(randomblob(16))), '555-345-6789', 1, 0, NULL, 1, 0, 0),
    
    ('a3b4c5d6-e7f8-a9b0-c1d2-e3f4a5b6c7d8', 'ronald.adams', 'RONALD.ADAMS', 'ronald.adams@example.com', 'RONALD.ADAMS@EXAMPLE.COM', 1,
    'AQAAAAIAAYagAAAAELBm+HePxTRc3YAzU5KFaz7jG7kALQQxVTS8/ZbVLbiH9HLmVvS7TJUJfvEGiwdShA==',
    lower(hex(randomblob(16))), lower(hex(randomblob(16))), '555-456-7890', 1, 0, NULL, 1, 0, 0),
    
    ('b4c5d6e7-f8a9-b0c1-d2e3-f4a5b6c7d8e9', 'sarah.baker', 'SARAH.BAKER', 'sarah.baker@example.com', 'SARAH.BAKER@EXAMPLE.COM', 1,
    'AQAAAAIAAYagAAAAELBm+HePxTRc3YAzU5KFaz7jG7kALQQxVTS8/ZbVLbiH9HLmVvS7TJUJfvEGiwdShA==',
    lower(hex(randomblob(16))), lower(hex(randomblob(16))), '555-567-8901', 1, 0, NULL, 1, 0, 0),
    
    ('c5d6e7f8-a9b0-c1d2-e3f4-a5b6c7d8e9f0', 'joseph.gonzalez', 'JOSEPH.GONZALEZ', 'joseph.gonzalez@example.com', 'JOSEPH.GONZALEZ@EXAMPLE.COM', 1,
    'AQAAAAIAAYagAAAAELBm+HePxTRc3YAzU5KFaz7jG7kALQQxVTS8/ZbVLbiH9HLmVvS7TJUJfvEGiwdShA==',
    lower(hex(randomblob(16))), lower(hex(randomblob(16))), '555-678-9012', 1, 0, NULL, 1, 0, 0),
    
    ('d6e7f8a9-b0c1-d2e3-f4a5-b6c7d8e9f0a1', 'carol.nelson', 'CAROL.NELSON', 'carol.nelson@example.com', 'CAROL.NELSON@EXAMPLE.COM', 1,
    'AQAAAAIAAYagAAAAELBm+HePxTRc3YAzU5KFaz7jG7kALQQxVTS8/ZbVLbiH9HLmVvS7TJUJfvEGiwdShA==',
    lower(hex(randomblob(16))), lower(hex(randomblob(16))), '555-789-0123', 1, 0, NULL, 1, 0, 0),
    
    ('e7f8a9b0-c1d2-e3f4-a5b6-c7d8e9f0a1b2', 'edward.carter', 'EDWARD.CARTER', 'edward.carter@example.com', 'EDWARD.CARTER@EXAMPLE.COM', 1,
    'AQAAAAIAAYagAAAAELBm+HePxTRc3YAzU5KFaz7jG7kALQQxVTS8/ZbVLbiH9HLmVvS7TJUJfvEGiwdShA==',
    lower(hex(randomblob(16))), lower(hex(randomblob(16))), '555-890-1234', 1, 0, NULL, 1, 0, 0),
    
    ('f8a9b0c1-d2e3-f4a5-b6c7-d8e9f0a1b2c3', 'sharon.mitchell', 'SHARON.MITCHELL', 'sharon.mitchell@example.com', 'SHARON.MITCHELL@EXAMPLE.COM', 1,
    'AQAAAAIAAYagAAAAELBm+HePxTRc3YAzU5KFaz7jG7kALQQxVTS8/ZbVLbiH9HLmVvS7TJUJfvEGiwdShA==',
    lower(hex(randomblob(16))), lower(hex(randomblob(16))), '555-901-2345', 1, 0, NULL, 1, 0, 0),
    
    ('a9b0c1d2-e3f4-a5b6-c7d8-e9f0a1b2c3d4', 'frank.perez', 'FRANK.PEREZ', 'frank.perez@example.com', 'FRANK.PEREZ@EXAMPLE.COM', 1,
    'AQAAAAIAAYagAAAAELBm+HePxTRc3YAzU5KFaz7jG7kALQQxVTS8/ZbVLbiH9HLmVvS7TJUJfvEGiwdShA==',
    lower(hex(randomblob(16))), lower(hex(randomblob(16))), '555-012-3456', 1, 0, NULL, 1, 0, 0),
    
    ('b0c1d2e3-f4a5-b6c7-d8e9-f0a1b2c3d4e5', 'michelle.roberts', 'MICHELLE.ROBERTS', 'michelle.roberts@example.com', 'MICHELLE.ROBERTS@EXAMPLE.COM', 1,
    'AQAAAAIAAYagAAAAELBm+HePxTRc3YAzU5KFaz7jG7kALQQxVTS8/ZbVLbiH9HLmVvS7TJUJfvEGiwdShA==',
    lower(hex(randomblob(16))), lower(hex(randomblob(16))), '555-123-4567', 1, 0, NULL, 1, 0, 0);

-- Group 5: Users (41-50)
INSERT OR IGNORE INTO AspNetUsers 
    (Id, UserName, NormalizedUserName, Email, NormalizedEmail, EmailConfirmed, 
    PasswordHash, SecurityStamp, ConcurrencyStamp, PhoneNumber, PhoneNumberConfirmed, 
    TwoFactorEnabled, LockoutEnd, LockoutEnabled, AccessFailedCount, Role)
VALUES
    ('c1d2e3f4-a5b6-c7d8-e9f0-a1b2c3d4e5f6', 'anthony.torres', 'ANTHONY.TORRES', 'anthony.torres@example.com', 'ANTHONY.TORRES@EXAMPLE.COM', 1,
    'AQAAAAIAAYagAAAAELBm+HePxTRc3YAzU5KFaz7jG7kALQQxVTS8/ZbVLbiH9HLmVvS7TJUJfvEGiwdShA==',
    lower(hex(randomblob(16))), lower(hex(randomblob(16))), '555-234-5678', 1, 0, NULL, 1, 0, 0),
    
    ('d2e3f4a5-b6c7-d8e9-f0a1-b2c3d4e5f6a7', 'laura.nguyen', 'LAURA.NGUYEN', 'laura.nguyen@example.com', 'LAURA.NGUYEN@EXAMPLE.COM', 1,
    'AQAAAAIAAYagAAAAELBm+HePxTRc3YAzU5KFaz7jG7kALQQxVTS8/ZbVLbiH9HLmVvS7TJUJfvEGiwdShA==',
    lower(hex(randomblob(16))), lower(hex(randomblob(16))), '555-345-6789', 1, 0, NULL, 1, 0, 0),
    
    ('e3f4a5b6-c7d8-e9f0-a1b2-c3d4e5f6a7b8', 'brian.rivera', 'BRIAN.RIVERA', 'brian.rivera@example.com', 'BRIAN.RIVERA@EXAMPLE.COM', 1,
    'AQAAAAIAAYagAAAAELBm+HePxTRc3YAzU5KFaz7jG7kALQQxVTS8/ZbVLbiH9HLmVvS7TJUJfvEGiwdShA==',
    lower(hex(randomblob(16))), lower(hex(randomblob(16))), '555-456-7890', 1, 0, NULL, 1, 0, 0),
    
    ('f4a5b6c7-d8e9-f0a1-b2c3-d4e5f6a7b8c9', 'kimberly.cooper', 'KIMBERLY.COOPER', 'kimberly.cooper@example.com', 'KIMBERLY.COOPER@EXAMPLE.COM', 1,
    'AQAAAAIAAYagAAAAELBm+HePxTRc3YAzU5KFaz7jG7kALQQxVTS8/ZbVLbiH9HLmVvS7TJUJfvEGiwdShA==',
    lower(hex(randomblob(16))), lower(hex(randomblob(16))), '555-567-8901', 1, 0, NULL, 1, 0, 0),
    
    ('a5b6c7d8-e9f0-a1b2-c3d4-e5f6a7b8c9d0', 'jeffrey.reed', 'JEFFREY.REED', 'jeffrey.reed@example.com', 'JEFFREY.REED@EXAMPLE.COM', 1,
    'AQAAAAIAAYagAAAAELBm+HePxTRc3YAzU5KFaz7jG7kALQQxVTS8/ZbVLbiH9HLmVvS7TJUJfvEGiwdShA==',
    lower(hex(randomblob(16))), lower(hex(randomblob(16))), '555-678-9012', 1, 0, NULL, 1, 0, 0),
    
    ('b6c7d8e9-f0a1-b2c3-d4e5-f6a7b8c9d0e1', 'amy.bailey', 'AMY.BAILEY', 'amy.bailey@example.com', 'AMY.BAILEY@EXAMPLE.COM', 1,
    'AQAAAAIAAYagAAAAELBm+HePxTRc3YAzU5KFaz7jG7kALQQxVTS8/ZbVLbiH9HLmVvS7TJUJfvEGiwdShA==',
    lower(hex(randomblob(16))), lower(hex(randomblob(16))), '555-789-0123', 1, 0, NULL, 1, 0, 0),
    
    ('c7d8e9f0-a1b2-c3d4-e5f6-a7b8c9d0e1f2', 'gary.simmons', 'GARY.SIMMONS', 'gary.simmons@example.com', 'GARY.SIMMONS@EXAMPLE.COM', 1,
    'AQAAAAIAAYagAAAAELBm+HePxTRc3YAzU5KFaz7jG7kALQQxVTS8/ZbVLbiH9HLmVvS7TJUJfvEGiwdShA==',
    lower(hex(randomblob(16))), lower(hex(randomblob(16))), '555-890-1234', 1, 0, NULL, 1, 0, 0),
    
    ('d8e9f0a1-b2c3-d4e5-f6a7-b8c9d0e1f2a3', 'virginia.howard', 'VIRGINIA.HOWARD', 'virginia.howard@example.com', 'VIRGINIA.HOWARD@EXAMPLE.COM', 1,
    'AQAAAAIAAYagAAAAELBm+HePxTRc3YAzU5KFaz7jG7kALQQxVTS8/ZbVLbiH9HLmVvS7TJUJfvEGiwdShA==',
    lower(hex(randomblob(16))), lower(hex(randomblob(16))), '555-901-2345', 1, 0, NULL, 1, 0, 0),
    
    ('e9f0a1b2-c3d4-e5f6-a7b8-c9d0e1f2a3b4', 'raymond.cox', 'RAYMOND.COX', 'raymond.cox@example.com', 'RAYMOND.COX@EXAMPLE.COM', 1,
    'AQAAAAIAAYagAAAAELBm+HePxTRc3YAzU5KFaz7jG7kALQQxVTS8/ZbVLbiH9HLmVvS7TJUJfvEGiwdShA==',
    lower(hex(randomblob(16))), lower(hex(randomblob(16))), '555-012-3456', 1, 0, NULL, 1, 0, 0),
    
    ('f0a1b2c3-d4e5-f6a7-b8c9-d0e1f2a3b4c5', 'catherine.ward', 'CATHERINE.WARD', 'catherine.ward@example.com', 'CATHERINE.WARD@EXAMPLE.COM', 1,
    'AQAAAAIAAYagAAAAELBm+HePxTRc3YAzU5KFaz7jG7kALQQxVTS8/ZbVLbiH9HLmVvS7TJUJfvEGiwdShA==',
    lower(hex(randomblob(16))), lower(hex(randomblob(16))), '555-123-4567', 1, 0, NULL, 1, 0, 0);

-- Group 6: Users (51-60)
INSERT OR IGNORE INTO AspNetUsers 
    (Id, UserName, NormalizedUserName, Email, NormalizedEmail, EmailConfirmed, 
    PasswordHash, SecurityStamp, ConcurrencyStamp, PhoneNumber, PhoneNumberConfirmed, 
    TwoFactorEnabled, LockoutEnd, LockoutEnabled, AccessFailedCount, Role)
VALUES
    ('a1b2c3d4-e5f6-a7b8-c9d0-e1f2a3b4c5d7', 'jack.watson', 'JACK.WATSON', 'jack.watson@example.com', 'JACK.WATSON@EXAMPLE.COM', 1,
    'AQAAAAIAAYagAAAAELBm+HePxTRc3YAzU5KFaz7jG7kALQQxVTS8/ZbVLbiH9HLmVvS7TJUJfvEGiwdShA==',
    lower(hex(randomblob(16))), lower(hex(randomblob(16))), '555-234-5678', 1, 0, NULL, 1, 0, 0),
    
    ('b2c3d4e5-f6a7-b8c9-d0e1-f2a3b4c5d6e8', 'janice.brooks', 'JANICE.BROOKS', 'janice.brooks@example.com', 'JANICE.BROOKS@EXAMPLE.COM', 1,
    'AQAAAAIAAYagAAAAELBm+HePxTRc3YAzU5KFaz7jG7kALQQxVTS8/ZbVLbiH9HLmVvS7TJUJfvEGiwdShA==',
    lower(hex(randomblob(16))), lower(hex(randomblob(16))), '555-345-6789', 1, 0, NULL, 1, 0, 0),
    
    ('c3d4e5f6-a7b8-c9d0-e1f2-a3b4c5d6e7f9', 'henry.bennett', 'HENRY.BENNETT', 'henry.bennett@example.com', 'HENRY.BENNETT@EXAMPLE.COM', 1,
    'AQAAAAIAAYagAAAAELBm+HePxTRc3YAzU5KFaz7jG7kALQQxVTS8/ZbVLbiH9HLmVvS7TJUJfvEGiwdShA==',
    lower(hex(randomblob(16))), lower(hex(randomblob(16))), '555-456-7890', 1, 0, NULL, 1, 0, 0),
    
    ('d4e5f6a7-b8c9-d0e1-f2a3-b4c5d6e7f8a0', 'ann.gray', 'ANN.GRAY', 'ann.gray@example.com', 'ANN.GRAY@EXAMPLE.COM', 1,
    'AQAAAAIAAYagAAAAELBm+HePxTRc3YAzU5KFaz7jG7kALQQxVTS8/ZbVLbiH9HLmVvS7TJUJfvEGiwdShA==',
    lower(hex(randomblob(16))), lower(hex(randomblob(16))), '555-567-8901', 1, 0, NULL, 1, 0, 0),
    
    ('e5f6a7b8-c9d0-e1f2-a3b4-c5d6e7f8a9b1', 'russell.james', 'RUSSELL.JAMES', 'russell.james@example.com', 'RUSSELL.JAMES@EXAMPLE.COM', 1,
    'AQAAAAIAAYagAAAAELBm+HePxTRc3YAzU5KFaz7jG7kALQQxVTS8/ZbVLbiH9HLmVvS7TJUJfvEGiwdShA==',
    lower(hex(randomblob(16))), lower(hex(randomblob(16))), '555-678-9012', 1, 0, NULL, 1, 0, 0),
    
    ('f6a7b8c9-d0e1-f2a3-b4c5-d6e7f8a9b0c2', 'judy.watson', 'JUDY.WATSON', 'judy.watson@example.com', 'JUDY.WATSON@EXAMPLE.COM', 1,
    'AQAAAAIAAYagAAAAELBm+HePxTRc3YAzU5KFaz7jG7kALQQxVTS8/ZbVLbiH9HLmVvS7TJUJfvEGiwdShA==',
    lower(hex(randomblob(16))), lower(hex(randomblob(16))), '555-789-0123', 1, 0, NULL, 1, 0, 0),
    
    ('a7b8c9d0-e1f2-a3b4-c5d6-e7f8a9b0c1d3', 'wayne.harrison', 'WAYNE.HARRISON', 'wayne.harrison@example.com', 'WAYNE.HARRISON@EXAMPLE.COM', 1,
    'AQAAAAIAAYagAAAAELBm+HePxTRc3YAzU5KFaz7jG7kALQQxVTS8/ZbVLbiH9HLmVvS7TJUJfvEGiwdShA==',
    lower(hex(randomblob(16))), lower(hex(randomblob(16))), '555-890-1234', 1, 0, NULL, 1, 0, 0),
    
    ('b8c9d0e1-f2a3-b4c5-d6e7-f8a9b0c1d2e4', 'beverly.kelly', 'BEVERLY.KELLY', 'beverly.kelly@example.com', 'BEVERLY.KELLY@EXAMPLE.COM', 1,
    'AQAAAAIAAYagAAAAELBm+HePxTRc3YAzU5KFaz7jG7kALQQxVTS8/ZbVLbiH9HLmVvS7TJUJfvEGiwdShA==',
    lower(hex(randomblob(16))), lower(hex(randomblob(16))), '555-901-2345', 1, 0, NULL, 1, 0, 0),
    
    ('c9d0e1f2-a3b4-c5d6-e7f8-a9b0c1d2e3f5', 'alan.howard', 'ALAN.HOWARD', 'alan.howard@example.com', 'ALAN.HOWARD@EXAMPLE.COM', 1,
    'AQAAAAIAAYagAAAAELBm+HePxTRc3YAzU5KFaz7jG7kALQQxVTS8/ZbVLbiH9HLmVvS7TJUJfvEGiwdShA==',
    lower(hex(randomblob(16))), lower(hex(randomblob(16))), '555-012-3456', 1, 0, NULL, 1, 0, 0),
      ('d0e1f2a3-b4c5-d6e7-f8a9-b0c1d2e3f4a6', 'denise.murphy', 'DENISE.MURPHY', 'denise.murphy@example.com', 'DENISE.MURPHY@EXAMPLE.COM', 1,
    'AQAAAAIAAYagAAAAELBm+HePxTRc3YAzU5KFaz7jG7kALQQxVTS8/ZbVLbiH9HLmVvS7TJUJfvEGiwdShA==',
    lower(hex(randomblob(16))), lower(hex(randomblob(16))), '555-123-4567', 1, 0, NULL, 1, 0, 0);

-- Group 7: Users (61-70)
INSERT OR IGNORE INTO AspNetUsers 
    (Id, UserName, NormalizedUserName, Email, NormalizedEmail, EmailConfirmed, 
    PasswordHash, SecurityStamp, ConcurrencyStamp, PhoneNumber, PhoneNumberConfirmed, 
    TwoFactorEnabled, LockoutEnd, LockoutEnabled, AccessFailedCount, Role)
VALUES
    ('e1f2a3b4-c5d6-e7f8-a9b0-c1d2e3f4a5b7', 'roy.sanders', 'ROY.SANDERS', 'roy.sanders@example.com', 'ROY.SANDERS@EXAMPLE.COM', 1,
    'AQAAAAIAAYagAAAAELBm+HePxTRc3YAzU5KFaz7jG7kALQQxVTS8/ZbVLbiH9HLmVvS7TJUJfvEGiwdShA==',
    lower(hex(randomblob(16))), lower(hex(randomblob(16))), '555-234-5678', 1, 0, NULL, 1, 0, 0),
    
    ('f2a3b4c5-d6e7-f8a9-b0c1-d2e3f4a5b6c8', 'kathryn.price', 'KATHRYN.PRICE', 'kathryn.price@example.com', 'KATHRYN.PRICE@EXAMPLE.COM', 1,
    'AQAAAAIAAYagAAAAELBm+HePxTRc3YAzU5KFaz7jG7kALQQxVTS8/ZbVLbiH9HLmVvS7TJUJfvEGiwdShA==',
    lower(hex(randomblob(16))), lower(hex(randomblob(16))), '555-345-6789', 1, 0, NULL, 1, 0, 0),
    
    ('a3b4c5d6-e7f8-a9b0-c1d2-e3f4a5b6c7d9', 'dennis.long', 'DENNIS.LONG', 'dennis.long@example.com', 'DENNIS.LONG@EXAMPLE.COM', 1,
    'AQAAAAIAAYagAAAAELBm+HePxTRc3YAzU5KFaz7jG7kALQQxVTS8/ZbVLbiH9HLmVvS7TJUJfvEGiwdShA==',
    lower(hex(randomblob(16))), lower(hex(randomblob(16))), '555-456-7890', 1, 0, NULL, 1, 0, 0),
    
    ('b4c5d6e7-f8a9-b0c1-d2e3-f4a5b6c7d8e0', 'frances.hughes', 'FRANCES.HUGHES', 'frances.hughes@example.com', 'FRANCES.HUGHES@EXAMPLE.COM', 1,
    'AQAAAAIAAYagAAAAELBm+HePxTRc3YAzU5KFaz7jG7kALQQxVTS8/ZbVLbiH9HLmVvS7TJUJfvEGiwdShA==',
    lower(hex(randomblob(16))), lower(hex(randomblob(16))), '555-567-8901', 1, 0, NULL, 1, 0, 0),
    
    ('c5d6e7f8-a9b0-c1d2-e3f4-a5b6c7d8e9f1', 'clarence.powell', 'CLARENCE.POWELL', 'clarence.powell@example.com', 'CLARENCE.POWELL@EXAMPLE.COM', 1,
    'AQAAAAIAAYagAAAAELBm+HePxTRc3YAzU5KFaz7jG7kALQQxVTS8/ZbVLbiH9HLmVvS7TJUJfvEGiwdShA==',
    lower(hex(randomblob(16))), lower(hex(randomblob(16))), '555-678-9012', 1, 0, NULL, 1, 0, 0),
    
    ('d6e7f8a9-b0c1-d2e3-f4a5-b6c7d8e9f0a2', 'tina.ross', 'TINA.ROSS', 'tina.ross@example.com', 'TINA.ROSS@EXAMPLE.COM', 1,
    'AQAAAAIAAYagAAAAELBm+HePxTRc3YAzU5KFaz7jG7kALQQxVTS8/ZbVLbiH9HLmVvS7TJUJfvEGiwdShA==',
    lower(hex(randomblob(16))), lower(hex(randomblob(16))), '555-789-0123', 1, 0, NULL, 1, 0, 0),
    
    ('e7f8a9b0-c1d2-e3f4-a5b6-c7d8e9f0a1b3', 'louis.perry', 'LOUIS.PERRY', 'louis.perry@example.com', 'LOUIS.PERRY@EXAMPLE.COM', 1,
    'AQAAAAIAAYagAAAAELBm+HePxTRc3YAzU5KFaz7jG7kALQQxVTS8/ZbVLbiH9HLmVvS7TJUJfvEGiwdShA==',
    lower(hex(randomblob(16))), lower(hex(randomblob(16))), '555-890-1234', 1, 0, NULL, 1, 0, 0),
    
    ('f8a9b0c1-d2e3-f4a5-b6c7-d8e9f0a1b2c4', 'mildred.butler', 'MILDRED.BUTLER', 'mildred.butler@example.com', 'MILDRED.BUTLER@EXAMPLE.COM', 1,
    'AQAAAAIAAYagAAAAELBm+HePxTRc3YAzU5KFaz7jG7kALQQxVTS8/ZbVLbiH9HLmVvS7TJUJfvEGiwdShA==',
    lower(hex(randomblob(16))), lower(hex(randomblob(16))), '555-901-2345', 1, 0, NULL, 1, 0, 0),
    
    ('a9b0c1d2-e3f4-a5b6-c7d8-e9f0a1b2c3d5', 'philip.simmons', 'PHILIP.SIMMONS', 'philip.simmons@example.com', 'PHILIP.SIMMONS@EXAMPLE.COM', 1,
    'AQAAAAIAAYagAAAAELBm+HePxTRc3YAzU5KFaz7jG7kALQQxVTS8/ZbVLbiH9HLmVvS7TJUJfvEGiwdShA==',
    lower(hex(randomblob(16))), lower(hex(randomblob(16))), '555-012-3456', 1, 0, NULL, 1, 0, 0),
    
    ('b0c1d2e3-f4a5-b6c7-d8e9-f0a1b2c3d4e6', 'alice.foster', 'ALICE.FOSTER', 'alice.foster@example.com', 'ALICE.FOSTER@EXAMPLE.COM', 1,
    'AQAAAAIAAYagAAAAELBm+HePxTRc3YAzU5KFaz7jG7kALQQxVTS8/ZbVLbiH9HLmVvS7TJUJfvEGiwdShA==',
    lower(hex(randomblob(16))), lower(hex(randomblob(16))), '555-123-4567', 1, 0, NULL, 1, 0, 0);

-- Group 8: Users (71-80)
INSERT OR IGNORE INTO AspNetUsers 
    (Id, UserName, NormalizedUserName, Email, NormalizedEmail, EmailConfirmed, 
    PasswordHash, SecurityStamp, ConcurrencyStamp, PhoneNumber, PhoneNumberConfirmed, 
    TwoFactorEnabled, LockoutEnd, LockoutEnabled, AccessFailedCount, Role)
VALUES
    ('c1d2e3f4-a5b6-c7d8-e9f0-a1b2c3d4e5f7', 'johnny.washington', 'JOHNNY.WASHINGTON', 'johnny.washington@example.com', 'JOHNNY.WASHINGTON@EXAMPLE.COM', 1,
    'AQAAAAIAAYagAAAAELBm+HePxTRc3YAzU5KFaz7jG7kALQQxVTS8/ZbVLbiH9HLmVvS7TJUJfvEGiwdShA==',
    lower(hex(randomblob(16))), lower(hex(randomblob(16))), '555-234-5678', 1, 0, NULL, 1, 0, 0),
    
    ('d2e3f4a5-b6c7-d8e9-f0a1-b2c3d4e5f6a8', 'gloria.barnes', 'GLORIA.BARNES', 'gloria.barnes@example.com', 'GLORIA.BARNES@EXAMPLE.COM', 1,
    'AQAAAAIAAYagAAAAELBm+HePxTRc3YAzU5KFaz7jG7kALQQxVTS8/ZbVLbiH9HLmVvS7TJUJfvEGiwdShA==',
    lower(hex(randomblob(16))), lower(hex(randomblob(16))), '555-345-6789', 1, 0, NULL, 1, 0, 0),
    
    ('e3f4a5b6-c7d8-e9f0-a1b2-c3d4e5f6a7b9', 'craig.fisher', 'CRAIG.FISHER', 'craig.fisher@example.com', 'CRAIG.FISHER@EXAMPLE.COM', 1,
    'AQAAAAIAAYagAAAAELBm+HePxTRc3YAzU5KFaz7jG7kALQQxVTS8/ZbVLbiH9HLmVvS7TJUJfvEGiwdShA==',
    lower(hex(randomblob(16))), lower(hex(randomblob(16))), '555-456-7890', 1, 0, NULL, 1, 0, 0),
    
    ('f4a5b6c7-d8e9-f0a1-b2c3-d4e5f6a7b8c0', 'teresa.henderson', 'TERESA.HENDERSON', 'teresa.henderson@example.com', 'TERESA.HENDERSON@EXAMPLE.COM', 1,
    'AQAAAAIAAYagAAAAELBm+HePxTRc3YAzU5KFaz7jG7kALQQxVTS8/ZbVLbiH9HLmVvS7TJUJfvEGiwdShA==',
    lower(hex(randomblob(16))), lower(hex(randomblob(16))), '555-567-8901', 1, 0, NULL, 1, 0, 0),
    
    ('a5b6c7d8-e9f0-a1b2-c3d4-e5f6a7b8c9d1', 'terry.coleman', 'TERRY.COLEMAN', 'terry.coleman@example.com', 'TERRY.COLEMAN@EXAMPLE.COM', 1,
    'AQAAAAIAAYagAAAAELBm+HePxTRc3YAzU5KFaz7jG7kALQQxVTS8/ZbVLbiH9HLmVvS7TJUJfvEGiwdShA==',
    lower(hex(randomblob(16))), lower(hex(randomblob(16))), '555-678-9012', 1, 0, NULL, 1, 0, 0),
    
    ('b6c7d8e9-f0a1-b2c3-d4e5-f6a7b8c9d0e2', 'joyce.jenkins', 'JOYCE.JENKINS', 'joyce.jenkins@example.com', 'JOYCE.JENKINS@EXAMPLE.COM', 1,
    'AQAAAAIAAYagAAAAELBm+HePxTRc3YAzU5KFaz7jG7kALQQxVTS8/ZbVLbiH9HLmVvS7TJUJfvEGiwdShA==',
    lower(hex(randomblob(16))), lower(hex(randomblob(16))), '555-789-0123', 1, 0, NULL, 1, 0, 0),
    
    ('c7d8e9f0-a1b2-c3d4-e5f6-a7b8c9d0e1f3', 'carl.patterson', 'CARL.PATTERSON', 'carl.patterson@example.com', 'CARL.PATTERSON@EXAMPLE.COM', 1,
    'AQAAAAIAAYagAAAAELBm+HePxTRc3YAzU5KFaz7jG7kALQQxVTS8/ZbVLbiH9HLmVvS7TJUJfvEGiwdShA==',
    lower(hex(randomblob(16))), lower(hex(randomblob(16))), '555-890-1234', 1, 0, NULL, 1, 0, 0),
    
    ('d8e9f0a1-b2c3-d4e5-f6a7-b8c9d0e1f2a4', 'ruby.flores', 'RUBY.FLORES', 'ruby.flores@example.com', 'RUBY.FLORES@EXAMPLE.COM', 1,
    'AQAAAAIAAYagAAAAELBm+HePxTRc3YAzU5KFaz7jG7kALQQxVTS8/ZbVLbiH9HLmVvS7TJUJfvEGiwdShA==',
    lower(hex(randomblob(16))), lower(hex(randomblob(16))), '555-901-2345', 1, 0, NULL, 1, 0, 0),
    
    ('e9f0a1b2-c3d4-e5f6-a7b8-c9d0e1f2a3b5', 'howard.washington', 'HOWARD.WASHINGTON', 'howard.washington@example.com', 'HOWARD.WASHINGTON@EXAMPLE.COM', 1,
    'AQAAAAIAAYagAAAAELBm+HePxTRc3YAzU5KFaz7jG7kALQQxVTS8/ZbVLbiH9HLmVvS7TJUJfvEGiwdShA==',
    lower(hex(randomblob(16))), lower(hex(randomblob(16))), '555-012-3456', 1, 0, NULL, 1, 0, 0),
    
    ('f0a1b2c3-d4e5-f6a7-b8c9-d0e1f2a3b4c6', 'tiffany.simmons', 'TIFFANY.SIMMONS', 'tiffany.simmons@example.com', 'TIFFANY.SIMMONS@EXAMPLE.COM', 1,
    'AQAAAAIAAYagAAAAELBm+HePxTRc3YAzU5KFaz7jG7kALQQxVTS8/ZbVLbiH9HLmVvS7TJUJfvEGiwdShA==',
    lower(hex(randomblob(16))), lower(hex(randomblob(16))), '555-123-4567', 1, 0, NULL, 1, 0, 0);

-- Group 9: Users (81-90)
INSERT OR IGNORE INTO AspNetUsers 
    (Id, UserName, NormalizedUserName, Email, NormalizedEmail, EmailConfirmed, 
    PasswordHash, SecurityStamp, ConcurrencyStamp, PhoneNumber, PhoneNumberConfirmed, 
    TwoFactorEnabled, LockoutEnd, LockoutEnabled, AccessFailedCount, Role)
VALUES
    ('a1b2c3d4-e5f6-a7b8-c9d0-e1f2a3b4c5d8', 'jerry.simpson', 'JERRY.SIMPSON', 'jerry.simpson@example.com', 'JERRY.SIMPSON@EXAMPLE.COM', 1,
    'AQAAAAIAAYagAAAAELBm+HePxTRc3YAzU5KFaz7jG7kALQQxVTS8/ZbVLbiH9HLmVvS7TJUJfvEGiwdShA==',
    lower(hex(randomblob(16))), lower(hex(randomblob(16))), '555-234-5678', 1, 0, NULL, 1, 0, 0),
    
    ('b2c3d4e5-f6a7-b8c9-d0e1-f2a3b4c5d6e9', 'katherine.rogers', 'KATHERINE.ROGERS', 'katherine.rogers@example.com', 'KATHERINE.ROGERS@EXAMPLE.COM', 1,
    'AQAAAAIAAYagAAAAELBm+HePxTRc3YAzU5KFaz7jG7kALQQxVTS8/ZbVLbiH9HLmVvS7TJUJfvEGiwdShA==',
    lower(hex(randomblob(16))), lower(hex(randomblob(16))), '555-345-6789', 1, 0, NULL, 1, 0, 0),
    
    ('c3d4e5f6-a7b8-c9d0-e1f2-a3b4c5d6e7f0', 'samuel.reed', 'SAMUEL.REED', 'samuel.reed@example.com', 'SAMUEL.REED@EXAMPLE.COM', 1,
    'AQAAAAIAAYagAAAAELBm+HePxTRc3YAzU5KFaz7jG7kALQQxVTS8/ZbVLbiH9HLmVvS7TJUJfvEGiwdShA==',
    lower(hex(randomblob(16))), lower(hex(randomblob(16))), '555-456-7890', 1, 0, NULL, 1, 0, 0),
    
    ('d4e5f6a7-b8c9-d0e1-f2a3-b4c5d6e7f8a1', 'jean.bell', 'JEAN.BELL', 'jean.bell@example.com', 'JEAN.BELL@EXAMPLE.COM', 1,
    'AQAAAAIAAYagAAAAELBm+HePxTRc3YAzU5KFaz7jG7kALQQxVTS8/ZbVLbiH9HLmVvS7TJUJfvEGiwdShA==',
    lower(hex(randomblob(16))), lower(hex(randomblob(16))), '555-567-8901', 1, 0, NULL, 1, 0, 0),
    
    ('e5f6a7b8-c9d0-e1f2-a3b4-c5d6e7f8a9b2', 'walter.alexander', 'WALTER.ALEXANDER', 'walter.alexander@example.com', 'WALTER.ALEXANDER@EXAMPLE.COM', 1,
    'AQAAAAIAAYagAAAAELBm+HePxTRc3YAzU5KFaz7jG7kALQQxVTS8/ZbVLbiH9HLmVvS7TJUJfvEGiwdShA==',
    lower(hex(randomblob(16))), lower(hex(randomblob(16))), '555-678-9012', 1, 0, NULL, 1, 0, 0),
    
    ('f6a7b8c9-d0e1-f2a3-b4c5-d6e7f8a9b0c3', 'rebecca.russell', 'REBECCA.RUSSELL', 'rebecca.russell@example.com', 'REBECCA.RUSSELL@EXAMPLE.COM', 1,
    'AQAAAAIAAYagAAAAELBm+HePxTRc3YAzU5KFaz7jG7kALQQxVTS8/ZbVLbiH9HLmVvS7TJUJfvEGiwdShA==',
    lower(hex(randomblob(16))), lower(hex(randomblob(16))), '555-789-0123', 1, 0, NULL, 1, 0, 0),
    
    ('a7b8c9d0-e1f2-a3b4-c5d6-e7f8a9b0c1d4', 'harold.griffin', 'HAROLD.GRIFFIN', 'harold.griffin@example.com', 'HAROLD.GRIFFIN@EXAMPLE.COM', 1,
    'AQAAAAIAAYagAAAAELBm+HePxTRc3YAzU5KFaz7jG7kALQQxVTS8/ZbVLbiH9HLmVvS7TJUJfvEGiwdShA==',
    lower(hex(randomblob(16))), lower(hex(randomblob(16))), '555-890-1234', 1, 0, NULL, 1, 0, 0),
    
    ('b8c9d0e1-f2a3-b4c5-d6e7-f8a9b0c1d2e5', 'stephanie.diaz', 'STEPHANIE.DIAZ', 'stephanie.diaz@example.com', 'STEPHANIE.DIAZ@EXAMPLE.COM', 1,
    'AQAAAAIAAYagAAAAELBm+HePxTRc3YAzU5KFaz7jG7kALQQxVTS8/ZbVLbiH9HLmVvS7TJUJfvEGiwdShA==',
    lower(hex(randomblob(16))), lower(hex(randomblob(16))), '555-901-2345', 1, 0, NULL, 1, 0, 0),
    
    ('c9d0e1f2-a3b4-c5d6-e7f8-a9b0c1d2e3f6', 'jeremy.hayes', 'JEREMY.HAYES', 'jeremy.hayes@example.com', 'JEREMY.HAYES@EXAMPLE.COM', 1,
    'AQAAAAIAAYagAAAAELBm+HePxTRc3YAzU5KFaz7jG7kALQQxVTS8/ZbVLbiH9HLmVvS7TJUJfvEGiwdShA==',
    lower(hex(randomblob(16))), lower(hex(randomblob(16))), '555-012-3456', 1, 0, NULL, 1, 0, 0),
    
    ('d0e1f2a3-b4c5-d6e7-f8a9-b0c1d2e3f4a7', 'pamela.myers', 'PAMELA.MYERS', 'pamela.myers@example.com', 'PAMELA.MYERS@EXAMPLE.COM', 1,
    'AQAAAAIAAYagAAAAELBm+HePxTRc3YAzU5KFaz7jG7kALQQxVTS8/ZbVLbiH9HLmVvS7TJUJfvEGiwdShA==',
    lower(hex(randomblob(16))), lower(hex(randomblob(16))), '555-123-4567', 1, 0, NULL, 1, 0, 0);

-- Group 10: Users (91-100) - Recent users (last 3 months)
INSERT OR IGNORE INTO AspNetUsers 
    (Id, UserName, NormalizedUserName, Email, NormalizedEmail, EmailConfirmed, 
    PasswordHash, SecurityStamp, ConcurrencyStamp, PhoneNumber, PhoneNumberConfirmed, 
    TwoFactorEnabled, LockoutEnd, LockoutEnabled, AccessFailedCount, Role)
VALUES
    ('e1f2a3b4-c5d6-e7f8-a9b0-c1d2e3f4a5b8', 'raymond.wood', 'RAYMOND.WOOD', 'raymond.wood@example.com', 'RAYMOND.WOOD@EXAMPLE.COM', 1,
    'AQAAAAIAAYagAAAAELBm+HePxTRc3YAzU5KFaz7jG7kALQQxVTS8/ZbVLbiH9HLmVvS7TJUJfvEGiwdShA==',
    lower(hex(randomblob(16))), lower(hex(randomblob(16))), '555-234-5678', 1, 0, NULL, 1, 0, 0),
    
    ('f2a3b4c5-d6e7-f8a9-b0c1-d2e3f4a5b6c9', 'victoria.james', 'VICTORIA.JAMES', 'victoria.james@example.com', 'VICTORIA.JAMES@EXAMPLE.COM', 1,
    'AQAAAAIAAYagAAAAELBm+HePxTRc3YAzU5KFaz7jG7kALQQxVTS8/ZbVLbiH9HLmVvS7TJUJfvEGiwdShA==',
    lower(hex(randomblob(16))), lower(hex(randomblob(16))), '555-345-6789', 1, 0, NULL, 1, 0, 0),
    
    ('a3b4c5d6-e7f8-a9b0-c1d2-e3f4a5b6c7d0', 'peter.watson', 'PETER.WATSON', 'peter.watson@example.com', 'PETER.WATSON@EXAMPLE.COM', 1,
    'AQAAAAIAAYagAAAAELBm+HePxTRc3YAzU5KFaz7jG7kALQQxVTS8/ZbVLbiH9HLmVvS7TJUJfvEGiwdShA==',
    lower(hex(randomblob(16))), lower(hex(randomblob(16))), '555-456-7890', 1, 0, NULL, 1, 0, 0),
    
    ('b4c5d6e7-f8a9-b0c1-d2e3-f4a5b6c7d8e1', 'amy.brooks', 'AMY.BROOKS', 'amy.brooks@example.com', 'AMY.BROOKS@EXAMPLE.COM', 1,
    'AQAAAAIAAYagAAAAELBm+HePxTRc3YAzU5KFaz7jG7kALQQxVTS8/ZbVLbiH9HLmVvS7TJUJfvEGiwdShA==',
    lower(hex(randomblob(16))), lower(hex(randomblob(16))), '555-567-8901', 1, 0, NULL, 1, 0, 0),
    
    ('c5d6e7f8-a9b0-c1d2-e3f4-a5b6c7d8e9f2', 'gregory.price', 'GREGORY.PRICE', 'gregory.price@example.com', 'GREGORY.PRICE@EXAMPLE.COM', 1,
    'AQAAAAIAAYagAAAAELBm+HePxTRc3YAzU5KFaz7jG7kALQQxVTS8/ZbVLbiH9HLmVvS7TJUJfvEGiwdShA==',
    lower(hex(randomblob(16))), lower(hex(randomblob(16))), '555-678-9012', 1, 0, NULL, 1, 0, 0),
    
    ('d6e7f8a9-b0c1-d2e3-f4a5-b6c7d8e9f0a3', 'nicole.bennett', 'NICOLE.BENNETT', 'nicole.bennett@example.com', 'NICOLE.BENNETT@EXAMPLE.COM', 1,
    'AQAAAAIAAYagAAAAELBm+HePxTRc3YAzU5KFaz7jG7kALQQxVTS8/ZbVLbiH9HLmVvS7TJUJfvEGiwdShA==',
    lower(hex(randomblob(16))), lower(hex(randomblob(16))), '555-789-0123', 1, 0, NULL, 1, 0, 0),
    
    ('e7f8a9b0-c1d2-e3f4-a5b6-c7d8e9f0a1b4', 'jeffrey.wood', 'JEFFREY.WOOD', 'jeffrey.wood@example.com', 'JEFFREY.WOOD@EXAMPLE.COM', 1,
    'AQAAAAIAAYagAAAAELBm+HePxTRc3YAzU5KFaz7jG7kALQQxVTS8/ZbVLbiH9HLmVvS7TJUJfvEGiwdShA==',
    lower(hex(randomblob(16))), lower(hex(randomblob(16))), '555-890-1234', 1, 0, NULL, 1, 0, 0),
    
    ('f8a9b0c1-d2e3-f4a5-b6c7-d8e9f0a1b2c5', 'cynthia.sanders', 'CYNTHIA.SANDERS', 'cynthia.sanders@example.com', 'CYNTHIA.SANDERS@EXAMPLE.COM', 1,
    'AQAAAAIAAYagAAAAELBm+HePxTRc3YAzU5KFaz7jG7kALQQxVTS8/ZbVLbiH9HLmVvS7TJUJfvEGiwdShA==',
    lower(hex(randomblob(16))), lower(hex(randomblob(16))), '555-901-2345', 1, 0, NULL, 1, 0, 0),
    
    ('a9b0c1d2-e3f4-a5b6-c7d8-e9f0a1b2c3d6', 'roger.coleman', 'ROGER.COLEMAN', 'roger.coleman@example.com', 'ROGER.COLEMAN@EXAMPLE.COM', 1,
    'AQAAAAIAAYagAAAAELBm+HePxTRc3YAzU5KFaz7jG7kALQQxVTS8/ZbVLbiH9HLmVvS7TJUJfvEGiwdShA==',
    lower(hex(randomblob(16))), lower(hex(randomblob(16))), '555-012-3456', 1, 0, NULL, 1, 0, 0),
    
    ('b0c1d2e3-f4a5-b6c7-d8e9-f0a1b2c3d4e7', 'monica.graham', 'MONICA.GRAHAM', 'monica.graham@example.com', 'MONICA.GRAHAM@EXAMPLE.COM', 1,
    'AQAAAAIAAYagAAAAELBm+HePxTRc3YAzU5KFaz7jG7kALQQxVTS8/ZbVLbiH9HLmVvS7TJUJfvEGiwdShA==',
    lower(hex(randomblob(16))), lower(hex(randomblob(16))), '555-123-4567', 1, 0, NULL, 1, 0, 0);



-- Support Agents
INSERT OR IGNORE INTO AspNetUserRoles (UserId, RoleId)
VALUES
    -- Long-time agents (3 years)
    ('70f2af46-88df-4025-adbd-e5382a5910e7', '92a54bcf-e21a-4f56-a620-3c2c4efd21ba'), -- john.thompson
    ('d57f79f4-5cc2-4a26-b2e6-0d4c65b0a844', '92a54bcf-e21a-4f56-a620-3c2c4efd21ba'), -- emily.reynolds
    ('eb15cb97-395e-4c5e-9112-a67bc324e8a3', '92a54bcf-e21a-4f56-a620-3c2c4efd21ba'), -- alexander.chen
    
    -- Mid-term agents (1-2 years)
    ('5d1c40b8-58a5-4d67-82b3-f7a6f3a68438', '92a54bcf-e21a-4f56-a620-3c2c4efd21ba'), -- sophia.patel
    ('13ed5b02-9857-4496-8be3-5409b95d2a1c', '92a54bcf-e21a-4f56-a620-3c2c4efd21ba'), -- daniel.rodriguez
    
    -- New agents (< 6 months)
    ('2af3bd42-1c6a-4cb1-a9f2-90bd2e258f1d', '92a54bcf-e21a-4f56-a620-3c2c4efd21ba'), -- olivia.washington
    ('84bf359e-f99d-46c3-8dbc-4c35cf0d6306', '92a54bcf-e21a-4f56-a620-3c2c4efd21ba'); -- benjamin.nguyen

-- End Users (100 users) - First batch (1-10)
INSERT OR IGNORE INTO AspNetUserRoles (UserId, RoleId)
VALUES
    -- Group 1: Long-time power users (3 years, frequent usage)
    ('6a8c63e1-7732-4553-8451-ca38f7a3bbdb', 'a319d0da-2ecf-44a2-8bfd-45e14e4c1657'), -- robert.johnson
    ('b7cd89c2-9355-40d5-a80a-7e917cdab69f', 'a319d0da-2ecf-44a2-8bfd-45e14e4c1657'), -- jennifer.smith
    ('e3f2dd17-f0ca-45fc-a1ca-d8a5e631bf6e', 'a319d0da-2ecf-44a2-8bfd-45e14e4c1657'), -- michael.williams
    ('cd5f1c8f-48d5-4dfb-91e4-91f0c38f7ea2', 'a319d0da-2ecf-44a2-8bfd-45e14e4c1657'), -- linda.brown
    ('e9c49e4b-0c7c-4484-9e3d-32638fd3c6d3', 'a319d0da-2ecf-44a2-8bfd-45e14e4c1657'), -- william.davis
    ('f8e26f09-7a28-40a5-a9dc-ef0d15f51316', 'a319d0da-2ecf-44a2-8bfd-45e14e4c1657'), -- elizabeth.miller
    ('7d91b8de-a9e7-4879-bb5a-b26e4167c215', 'a319d0da-2ecf-44a2-8bfd-45e14e4c1657'), -- james.wilson
    ('2c5d9939-6679-422a-b83c-58cbd4215b12', 'a319d0da-2ecf-44a2-8bfd-45e14e4c1657'), -- patricia.moore
    ('b5a9b7a7-90a9-4c7e-8aff-10a86801d0cb', 'a319d0da-2ecf-44a2-8bfd-45e14e4c1657'), -- david.taylor
    ('9a9e9c1c-5a5a-4b9a-8a9c-5c5a5a9c1c5a', 'a319d0da-2ecf-44a2-8bfd-45e14e4c1657'); -- susan.anderson

-- End Users (11-20)
INSERT OR IGNORE INTO AspNetUserRoles (UserId, RoleId)
VALUES
    -- Group 2: Mid-term users (1-2 years, moderate usage)
    ('1a2b3c4d-5e6f-7a8b-9c0d-1e2f3a4b5c6d', 'a319d0da-2ecf-44a2-8bfd-45e14e4c1657'), -- richard.thomas
    ('2b3c4d5e-6f7a-8b9c-0d1e-2f3a4b5c6d7e', 'a319d0da-2ecf-44a2-8bfd-45e14e4c1657'), -- karen.jackson
    ('3c4d5e6f-7a8b-9c0d-1e2f-3a4b5c6d7e8f', 'a319d0da-2ecf-44a2-8bfd-45e14e4c1657'), -- charles.white
    ('4d5e6f7a-8b9c-0d1e-2f3a-4b5c6d7e8f9a', 'a319d0da-2ecf-44a2-8bfd-45e14e4c1657'), -- nancy.harris
    ('5e6f7a8b-9c0d-1e2f-3a4b-5c6d7e8f9a0b', 'a319d0da-2ecf-44a2-8bfd-45e14e4c1657'), -- thomas.martin
    ('6f7a8b9c-0d1e-2f3a-4b5c-6d7e8f9a0b1c', 'a319d0da-2ecf-44a2-8bfd-45e14e4c1657'), -- lisa.thompson
    ('7a8b9c0d-1e2f-3a4b-5c6d-7e8f9a0b1c2d', 'a319d0da-2ecf-44a2-8bfd-45e14e4c1657'), -- george.garcia
    ('8b9c0d1e-2f3a-4b5c-6d7e-8f9a0b1c2d3e', 'a319d0da-2ecf-44a2-8bfd-45e14e4c1657'), -- sandra.martinez
    ('9c0d1e2f-3a4b-5c6d-7e8f-9a0b1c2d3e4f', 'a319d0da-2ecf-44a2-8bfd-45e14e4c1657'), -- kenneth.robinson
    ('0d1e2f3a-4b5c-6d7e-8f9a-0b1c2d3e4f5a', 'a319d0da-2ecf-44a2-8bfd-45e14e4c1657'); -- donna.clark

-- End Users (21-30)
INSERT OR IGNORE INTO AspNetUserRoles (UserId, RoleId)
VALUES
    -- Group 3: Recent users (last 10 months)
    ('a1b2c3d4-e5f6-a7b8-c9d0-e1f2a3b4c5d6', 'a319d0da-2ecf-44a2-8bfd-45e14e4c1657'), -- steve.rodriguez
    ('b2c3d4e5-f6a7-b8c9-d0e1-f2a3b4c5d6e7', 'a319d0da-2ecf-44a2-8bfd-45e14e4c1657'), -- helen.lee
    ('c3d4e5f6-a7b8-c9d0-e1f2-a3b4c5d6e7f8', 'a319d0da-2ecf-44a2-8bfd-45e14e4c1657'), -- paul.walker
    ('d4e5f6a7-b8c9-d0e1-f2a3-b4c5d6e7f8a9', 'a319d0da-2ecf-44a2-8bfd-45e14e4c1657'), -- deborah.hall
    ('e5f6a7b8-c9d0-e1f2-a3b4-c5d6e7f8a9b0', 'a319d0da-2ecf-44a2-8bfd-45e14e4c1657'), -- mark.allen
    ('f6a7b8c9-d0e1-f2a3-b4c5-d6e7f8a9b0c1', 'a319d0da-2ecf-44a2-8bfd-45e14e4c1657'), -- cynthia.young
    ('a7b8c9d0-e1f2-a3b4-c5d6-e7f8a9b0c1d2', 'a319d0da-2ecf-44a2-8bfd-45e14e4c1657'), -- andrew.king
    ('b8c9d0e1-f2a3-b4c5-d6e7-f8a9b0c1d2e3', 'a319d0da-2ecf-44a2-8bfd-45e14e4c1657'), -- ruth.wright
    ('c9d0e1f2-a3b4-c5d6-e7f8-a9b0c1d2e3f4', 'a319d0da-2ecf-44a2-8bfd-45e14e4c1657'), -- steven.lopez
    ('d0e1f2a3-b4c5-d6e7-f8a9-b0c1d2e3f4a5', 'a319d0da-2ecf-44a2-8bfd-45e14e4c1657'); -- betty.hill

-- Continue with remaining user role assignments for users 31-100
INSERT OR IGNORE INTO AspNetUserRoles (UserId, RoleId)
VALUES
    -- Group 4: Users (31-40)
    ('e1f2a3b4-c5d6-e7f8-a9b0-c1d2e3f4a5b6', 'a319d0da-2ecf-44a2-8bfd-45e14e4c1657'), -- kevin.scott
    ('f2a3b4c5-d6e7-f8a9-b0c1-d2e3f4a5b6c7', 'a319d0da-2ecf-44a2-8bfd-45e14e4c1657'), -- sarah.green
    ('a3b4c5d6-e7f8-a9b0-c1d2-e3f4a5b6c7d8', 'a319d0da-2ecf-44a2-8bfd-45e14e4c1657'), -- edward.baker
    ('b4c5d6e7-f8a9-b0c1-d2e3-f4a5b6c7d8e9', 'a319d0da-2ecf-44a2-8bfd-45e14e4c1657'), -- carol.gonzalez
    ('c5d6e7f8-a9b0-c1d2-e3f4-a5b6c7d8e9f0', 'a319d0da-2ecf-44a2-8bfd-45e14e4c1657'), -- brian.nelson
    ('d6e7f8a9-b0c1-d2e3-f4a5-b6c7d8e9f0a1', 'a319d0da-2ecf-44a2-8bfd-45e14e4c1657'), -- amanda.carter
    ('e7f8a9b0-c1d2-e3f4-a5b6-c7d8e9f0a1b2', 'a319d0da-2ecf-44a2-8bfd-45e14e4c1657'), -- joseph.mitchell
    ('f8a9b0c1-d2e3-f4a5-b6c7-d8e9f0a1b2c3', 'a319d0da-2ecf-44a2-8bfd-45e14e4c1657'), -- diane.perez
    ('a9b0c1d2-e3f4-a5b6-c7d8-e9f0a1b2c3d4', 'a319d0da-2ecf-44a2-8bfd-45e14e4c1657'), -- gerald.roberts
    ('b0c1d2e3-f4a5-b6c7-d8e9-f0a1b2c3d4e5', 'a319d0da-2ecf-44a2-8bfd-45e14e4c1657'); -- kathleen.turner

-- Group 5: Users (41-50)
INSERT OR IGNORE INTO AspNetUserRoles (UserId, RoleId)
VALUES
    ('c1d2e3f4-a5b6-c7d8-e9f0-a1b2c3d4e5f6', 'a319d0da-2ecf-44a2-8bfd-45e14e4c1657'), -- ryan.phillips
    ('d2e3f4a5-b6c7-d8e9-f0a1-b2c3d4e5f6a7', 'a319d0da-2ecf-44a2-8bfd-45e14e4c1657'), -- maria.campbell
    ('e3f4a5b6-c7d8-e9f0-a1b2-c3d4e5f6a7b8', 'a319d0da-2ecf-44a2-8bfd-45e14e4c1657'), -- larry.parker
    ('f4a5b6c7-d8e9-f0a1-b2c3-d4e5f6a7b8c9', 'a319d0da-2ecf-44a2-8bfd-45e14e4c1657'), -- nancy.evans
    ('a5b6c7d8-e9f0-a1b2-c3d4-e5f6a7b8c9d0', 'a319d0da-2ecf-44a2-8bfd-45e14e4c1657'), -- frank.edwards
    ('b6c7d8e9-f0a1-b2c3-d4e5-f6a7b8c9d0e1', 'a319d0da-2ecf-44a2-8bfd-45e14e4c1657'), -- laura.collins
    ('c7d8e9f0-a1b2-c3d4-e5f6-a7b8c9d0e1f2', 'a319d0da-2ecf-44a2-8bfd-45e14e4c1657'), -- raymond.stewart
    ('d8e9f0a1-b2c3-d4e5-f6a7-b8c9d0e1f2a3', 'a319d0da-2ecf-44a2-8bfd-45e14e4c1657'), -- judith.sanchez
    ('e9f0a1b2-c3d4-e5f6-a7b8-c9d0e1f2a3b4', 'a319d0da-2ecf-44a2-8bfd-45e14e4c1657'), -- wayne.morris
    ('f0a1b2c3-d4e5-f6a7-b8c9-d0e1f2a3b4c5', 'a319d0da-2ecf-44a2-8bfd-45e14e4c1657'); -- melissa.rogers

-- Group 6: Users (51-60)
INSERT OR IGNORE INTO AspNetUserRoles (UserId, RoleId)
VALUES
    ('a1b2c3d4-e5f6-a7b8-c9d0-e1f2a3b4c5d7', 'a319d0da-2ecf-44a2-8bfd-45e14e4c1657'), -- dennis.reed
    ('b2c3d4e5-f6a7-b8c9-d0e1-f2a3b4c5d6e8', 'a319d0da-2ecf-44a2-8bfd-45e14e4c1657'), -- carolyn.cook
    ('c3d4e5f6-a7b8-c9d0-e1f2-a3b4c5d6e7f9', 'a319d0da-2ecf-44a2-8bfd-45e14e4c1657'), -- gary.morgan
    ('d4e5f6a7-b8c9-d0e1-f2a3-b4c5d6e7f8a0', 'a319d0da-2ecf-44a2-8bfd-45e14e4c1657'), -- christine.bell
    ('e5f6a7b8-c9d0-e1f2-a3b4-c5d6e7f8a9b1', 'a319d0da-2ecf-44a2-8bfd-45e14e4c1657'), -- michael.murphy
    ('f6a7b8c9-d0e1-f2a3-b4c5-d6e7f8a9b0c2', 'a319d0da-2ecf-44a2-8bfd-45e14e4c1657'), -- jessica.bailey
    ('a7b8c9d0-e1f2-a3b4-c5d6-e7f8a9b0c1d3', 'a319d0da-2ecf-44a2-8bfd-45e14e4c1657'), -- timothy.rivera
    ('b8c9d0e1-f2a3-b4c5-d6e7-f8a9b0c1d2e4', 'a319d0da-2ecf-44a2-8bfd-45e14e4c1657'), -- shirley.cooper
    ('c9d0e1f2-a3b4-c5d6-e7f8-a9b0c1d2e3f5', 'a319d0da-2ecf-44a2-8bfd-45e14e4c1657'), -- anthony.richardson
    ('d0e1f2a3-b4c5-d6e7-f8a9-b0c1d2e3f4a6', 'a319d0da-2ecf-44a2-8bfd-45e14e4c1657'); -- evelyn.cox

-- Group 7: Users (61-70)
INSERT OR IGNORE INTO AspNetUserRoles (UserId, RoleId)
VALUES
    ('e1f2a3b4-c5d6-e7f8-a9b0-c1d2e3f4a5b7', 'a319d0da-2ecf-44a2-8bfd-45e14e4c1657'), -- roy.howard
    ('f2a3b4c5-d6e7-f8a9-b0c1-d2e3f4a5b6c8', 'a319d0da-2ecf-44a2-8bfd-45e14e4c1657'), -- frances.ward
    ('a3b4c5d6-e7f8-a9b0-c1d2-e3f4a5b6c7d9', 'a319d0da-2ecf-44a2-8bfd-45e14e4c1657'), -- louis.torres
    ('b4c5d6e7-f8a9-b0c1-d2e3-f4a5b6c7d8e0', 'a319d0da-2ecf-44a2-8bfd-45e14e4c1657'), -- cheryl.peterson
    ('c5d6e7f8-a9b0-c1d2-e3f4-a5b6c7d8e9f1', 'a319d0da-2ecf-44a2-8bfd-45e14e4c1657'), -- alan.gray
    ('d6e7f8a9-b0c1-d2e3-f4a5-b6c7d8e9f0a2', 'a319d0da-2ecf-44a2-8bfd-45e14e4c1657'), -- rachel.ramirez
    ('e7f8a9b0-c1d2-e3f4-a5b6-c7d8e9f0a1b3', 'a319d0da-2ecf-44a2-8bfd-45e14e4c1657'), -- bruce.james
    ('f8a9b0c1-d2e3-f4a5-b6c7-d8e9f0a1b2c4', 'a319d0da-2ecf-44a2-8bfd-45e14e4c1657'), -- virginia.watson
    ('a9b0c1d2-e3f4-a5b6-c7d8-e9f0a1b2c3d5', 'a319d0da-2ecf-44a2-8bfd-45e14e4c1657'), -- philip.brooks
    ('b0c1d2e3-f4a5-b6c7-d8e9-f0a1b2c3d4e6', 'a319d0da-2ecf-44a2-8bfd-45e14e4c1657'); -- catherine.kelly

-- Group 8: Users (71-80)
INSERT OR IGNORE INTO AspNetUserRoles (UserId, RoleId)
VALUES
    ('c1d2e3f4-a5b6-c7d8-e9f0-a1b2c3d4e5f7', 'a319d0da-2ecf-44a2-8bfd-45e14e4c1657'), -- johnny.sanders
    ('d2e3f4a5-b6c7-d8e9-f0a1-b2c3d4e5f6a8', 'a319d0da-2ecf-44a2-8bfd-45e14e4c1657'), -- janice.price
    ('e3f4a5b6-c7d8-e9f0-a1b2-c3d4e5f6a7b9', 'a319d0da-2ecf-44a2-8bfd-45e14e4c1657'), -- randy.bennett
    ('f4a5b6c7-d8e9-f0a1-b2c3-d4e5f6a7b8c0', 'a319d0da-2ecf-44a2-8bfd-45e14e4c1657'), -- beverly.wood
    ('a5b6c7d8-e9f0-a1b2-c3d4-e5f6a7b8c9d1', 'a319d0da-2ecf-44a2-8bfd-45e14e4c1657'), -- arthur.barnes
    ('b6c7d8e9-f0a1-b2c3-d4e5-f6a7b8c9d0e2', 'a319d0da-2ecf-44a2-8bfd-45e14e4c1657'), -- joyce.jenkins
    ('c7d8e9f0-a1b2-c3d4-e5f6-a7b8c9d0e1f3', 'a319d0da-2ecf-44a2-8bfd-45e14e4c1657'), -- carl.patterson
    ('d8e9f0a1-b2c3-d4e5-f6a7-b8c9d0e1f2a4', 'a319d0da-2ecf-44a2-8bfd-45e14e4c1657'), -- ruby.flores
    ('e9f0a1b2-c3d4-e5f6-a7b8-c9d0e1f2a3b5', 'a319d0da-2ecf-44a2-8bfd-45e14e4c1657'), -- howard.washington
    ('f0a1b2c3-d4e5-f6a7-b8c9-d0e1f2a3b4c6', 'a319d0da-2ecf-44a2-8bfd-45e14e4c1657'); -- tiffany.simmons

-- Group 9: Users (81-90)
INSERT OR IGNORE INTO AspNetUserRoles (UserId, RoleId)
VALUES
    ('a1b2c3d4-e5f6-a7b8-c9d0-e1f2a3b4c5d8', 'a319d0da-2ecf-44a2-8bfd-45e14e4c1657'), -- jerry.simpson
    ('b2c3d4e5-f6a7-b8c9-d0e1-f2a3b4c5d6e9', 'a319d0da-2ecf-44a2-8bfd-45e14e4c1657'), -- katherine.rogers
    ('c3d4e5f6-a7b8-c9d0-e1f2-a3b4c5d6e7f0', 'a319d0da-2ecf-44a2-8bfd-45e14e4c1657'), -- samuel.reed
    ('d4e5f6a7-b8c9-d0e1-f2a3-b4c5d6e7f8a1', 'a319d0da-2ecf-44a2-8bfd-45e14e4c1657'), -- jean.bell
    ('e5f6a7b8-c9d0-e1f2-a3b4-c5d6e7f8a9b2', 'a319d0da-2ecf-44a2-8bfd-45e14e4c1657'), -- walter.alexander
    ('f6a7b8c9-d0e1-f2a3-b4c5-d6e7f8a9b0c3', 'a319d0da-2ecf-44a2-8bfd-45e14e4c1657'), -- rebecca.russell
    ('a7b8c9d0-e1f2-a3b4-c5d6-e7f8a9b0c1d4', 'a319d0da-2ecf-44a2-8bfd-45e14e4c1657'), -- harold.griffin
    ('b8c9d0e1-f2a3-b4c5-d6e7-f8a9b0c1d2e5', 'a319d0da-2ecf-44a2-8bfd-45e14e4c1657'), -- stephanie.diaz
    ('c9d0e1f2-a3b4-c5d6-e7f8-a9b0c1d2e3f6', 'a319d0da-2ecf-44a2-8bfd-45e14e4c1657'), -- jeremy.hayes
    ('d0e1f2a3-b4c5-d6e7-f8a9-b0c1d2e3f4a7', 'a319d0da-2ecf-44a2-8bfd-45e14e4c1657'); -- pamela.myers

-- Group 10: Users (91-100) - Recent users (last 3 months)
INSERT OR IGNORE INTO AspNetUserRoles (UserId, RoleId)
VALUES
    ('e1f2a3b4-c5d6-e7f8-a9b0-c1d2e3f4a5b8', 'a319d0da-2ecf-44a2-8bfd-45e14e4c1657'), -- raymond.wood
    ('f2a3b4c5-d6e7-f8a9-b0c1-d2e3f4a5b6c9', 'a319d0da-2ecf-44a2-8bfd-45e14e4c1657'), -- victoria.james
    ('a3b4c5d6-e7f8-a9b0-c1d2-e3f4a5b6c7d0', 'a319d0da-2ecf-44a2-8bfd-45e14e4c1657'), -- peter.watson
    ('b4c5d6e7-f8a9-b0c1-d2e3-f4a5b6c7d8e1', 'a319d0da-2ecf-44a2-8bfd-45e14e4c1657'), -- amy.brooks
    ('c5d6e7f8-a9b0-c1d2-e3f4-a5b6c7d8e9f2', 'a319d0da-2ecf-44a2-8bfd-45e14e4c1657'), -- gregory.price
    ('d6e7f8a9-b0c1-d2e3-f4a5-b6c7d8e9f0a3', 'a319d0da-2ecf-44a2-8bfd-45e14e4c1657'), -- nicole.bennett
    ('e7f8a9b0-c1d2-e3f4-a5b6-c7d8e9f0a1b4', 'a319d0da-2ecf-44a2-8bfd-45e14e4c1657'), -- jeffrey.wood
    ('f8a9b0c1-d2e3-f4a5-b6c7-d8e9f0a1b2c5', 'a319d0da-2ecf-44a2-8bfd-45e14e4c1657'), -- cynthia.sanders
    ('a9b0c1d2-e3f4-a5b6-c7d8-e9f0a1b2c3d6', 'a319d0da-2ecf-44a2-8bfd-45e14e4c1657'), -- roger.coleman
    ('b0c1d2e3-f4a5-b6c7-d8e9-f0a1b2c3d4e7', 'a319d0da-2ecf-44a2-8bfd-45e14e4c1657'); -- monica.graham