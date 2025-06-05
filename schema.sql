-- ASP.NET Core Identity tables
CREATE TABLE AspNetUsers (
    Id TEXT PRIMARY KEY,
    Role INTEGER NOT NULL,
    UserName TEXT(256),
    NormalizedUserName TEXT(256),
    Email TEXT(256),
    NormalizedEmail TEXT(256),
    EmailConfirmed INTEGER NOT NULL,
    PasswordHash TEXT,
    SecurityStamp TEXT,
    ConcurrencyStamp TEXT,
    PhoneNumber TEXT,
    PhoneNumberConfirmed INTEGER NOT NULL,
    TwoFactorEnabled INTEGER NOT NULL,
    LockoutEnd TEXT,
    LockoutEnabled INTEGER NOT NULL,
    AccessFailedCount INTEGER NOT NULL
);

CREATE TABLE AspNetRoles (
    Id TEXT PRIMARY KEY,
    Name TEXT(256),
    NormalizedName TEXT(256),
    ConcurrencyStamp TEXT
);

CREATE TABLE AspNetUserRoles (
    UserId TEXT NOT NULL,
    RoleId TEXT NOT NULL,
    PRIMARY KEY (UserId, RoleId),
    FOREIGN KEY (UserId) REFERENCES AspNetUsers(Id) ON DELETE CASCADE,
    FOREIGN KEY (RoleId) REFERENCES AspNetRoles(Id) ON DELETE CASCADE
);

CREATE TABLE AspNetUserClaims (
    Id INTEGER PRIMARY KEY AUTOINCREMENT,
    UserId TEXT NOT NULL,
    ClaimType TEXT,
    ClaimValue TEXT,
    FOREIGN KEY (UserId) REFERENCES AspNetUsers(Id) ON DELETE CASCADE
);

CREATE TABLE AspNetUserLogins (
    LoginProvider TEXT NOT NULL,
    ProviderKey TEXT NOT NULL,
    ProviderDisplayName TEXT,
    UserId TEXT NOT NULL,
    PRIMARY KEY (LoginProvider, ProviderKey),
    FOREIGN KEY (UserId) REFERENCES AspNetUsers(Id) ON DELETE CASCADE
);

CREATE TABLE AspNetUserTokens (
    UserId TEXT NOT NULL,
    LoginProvider TEXT NOT NULL,
    Name TEXT NOT NULL,
    Value TEXT,
    PRIMARY KEY (UserId, LoginProvider, Name),
    FOREIGN KEY (UserId) REFERENCES AspNetUsers(Id) ON DELETE CASCADE
);

CREATE TABLE AspNetRoleClaims (
    Id INTEGER PRIMARY KEY AUTOINCREMENT,
    RoleId TEXT NOT NULL,
    ClaimType TEXT,
    ClaimValue TEXT,
    FOREIGN KEY (RoleId) REFERENCES AspNetRoles(Id) ON DELETE CASCADE
);

-- Tickets and related tables
CREATE TABLE Tickets (
    Id INTEGER PRIMARY KEY AUTOINCREMENT,
    Title TEXT NOT NULL,
    Description TEXT NOT NULL,
    Status INTEGER NOT NULL,
    Priority INTEGER NOT NULL,
    CreatedById TEXT NOT NULL,
    AssignedToId TEXT,
    CreatedAt TEXT NOT NULL,
    UpdatedAt TEXT,
    Category TEXT(100) NOT NULL,
    TechArea TEXT(100),
    AttachmentUrl TEXT,
    FOREIGN KEY (CreatedById) REFERENCES AspNetUsers(Id) ON DELETE RESTRICT,
    FOREIGN KEY (AssignedToId) REFERENCES AspNetUsers(Id) ON DELETE SET NULL
);

CREATE TABLE TicketComments (
    Id INTEGER PRIMARY KEY AUTOINCREMENT,
    TicketId INTEGER NOT NULL,
    Content TEXT NOT NULL,
    CreatedById TEXT NOT NULL,
    CreatedAt TEXT NOT NULL,
    LastModifiedAt TEXT,
    IsEdited INTEGER NOT NULL,
    FOREIGN KEY (TicketId) REFERENCES Tickets(Id) ON DELETE CASCADE,
    FOREIGN KEY (CreatedById) REFERENCES AspNetUsers(Id) ON DELETE RESTRICT
);

CREATE TABLE TicketAttachments (
    Id INTEGER PRIMARY KEY AUTOINCREMENT,
    TicketId INTEGER NOT NULL,
    FileName TEXT(255) NOT NULL,
    FileSize INTEGER NOT NULL,
    ContentType TEXT(100) NOT NULL,
    UploadedById TEXT NOT NULL,
    UploadedAt TEXT NOT NULL,
    FilePath TEXT(255) NOT NULL,
    FOREIGN KEY (TicketId) REFERENCES Tickets(Id) ON DELETE CASCADE,
    FOREIGN KEY (UploadedById) REFERENCES AspNetUsers(Id) ON DELETE RESTRICT
);

CREATE TABLE TicketAudits (
    Id INTEGER PRIMARY KEY AUTOINCREMENT,
    TicketId INTEGER NOT NULL,
    Action TEXT NOT NULL,
    FieldName TEXT NOT NULL,
    OldValue TEXT,
    NewValue TEXT,
    ChangedById TEXT NOT NULL,
    ChangedAt TEXT NOT NULL,
    FOREIGN KEY (TicketId) REFERENCES Tickets(Id) ON DELETE CASCADE,
    FOREIGN KEY (ChangedById) REFERENCES AspNetUsers(Id) ON DELETE RESTRICT
);

CREATE TABLE Notifications (
    Id INTEGER PRIMARY KEY AUTOINCREMENT,
    UserId TEXT NOT NULL,
    TicketId INTEGER NOT NULL,
    Type INTEGER NOT NULL,
    Message TEXT NOT NULL,
    CreatedAt TEXT NOT NULL,
    IsRead INTEGER NOT NULL,
    ReadAt TEXT,
    FOREIGN KEY (UserId) REFERENCES AspNetUsers(Id) ON DELETE CASCADE,
    FOREIGN KEY (TicketId) REFERENCES Tickets(Id) ON DELETE CASCADE
);

-- Indexes (as in migration)
CREATE UNIQUE INDEX IX_AspNetUsers_UserName ON AspNetUsers (NormalizedUserName);
CREATE INDEX IX_AspNetUsers_Email ON AspNetUsers (NormalizedEmail);
CREATE INDEX IX_Tickets_AssignedToId ON Tickets (AssignedToId);
CREATE INDEX IX_Tickets_CreatedById ON Tickets (CreatedById);
CREATE INDEX IX_Tickets_Status ON Tickets (Status);
CREATE INDEX IX_TicketComments_TicketId ON TicketComments (TicketId);
CREATE INDEX IX_TicketComments_CreatedById ON TicketComments (CreatedById);
CREATE INDEX IX_TicketAttachments_TicketId ON TicketAttachments (TicketId);
CREATE INDEX IX_TicketAttachments_UploadedById ON TicketAttachments (UploadedById);
CREATE INDEX IX_TicketAudits_TicketId ON TicketAudits (TicketId);
CREATE INDEX IX_TicketAudits_ChangedById ON TicketAudits (ChangedById);
CREATE INDEX IX_Notifications_UserId ON Notifications (UserId);
CREATE INDEX IX_Notifications_TicketId ON Notifications (TicketId);
CREATE INDEX IX_Notifications_UserId_IsRead ON Notifications (UserId, IsRead);