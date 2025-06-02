-- Users table
CREATE TABLE Users (
    Id INTEGER PRIMARY KEY AUTOINCREMENT,
    Username TEXT NOT NULL UNIQUE,
    Email TEXT NOT NULL UNIQUE,
    PasswordHash TEXT NOT NULL,
    Role TEXT NOT NULL CHECK (Role IN ('EndUser', 'SupportAgent', 'Admin'))
);

-- Tickets table
CREATE TABLE Tickets (
    Id INTEGER PRIMARY KEY AUTOINCREMENT,
    Title TEXT NOT NULL,
    Description TEXT NOT NULL,
    Priority TEXT NOT NULL,
    Status TEXT NOT NULL CHECK (Status IN ('Open', 'In Progress', 'Closed')),
    Category TEXT NOT NULL,
    TechArea TEXT NOT NULL,
    CreatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    UpdatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CreatedBy INTEGER NOT NULL,
    AssignedTo INTEGER,
    FOREIGN KEY (CreatedBy) REFERENCES Users(Id),
    FOREIGN KEY (AssignedTo) REFERENCES Users(Id)
);

-- Attachments table
CREATE TABLE Attachments (
    Id INTEGER PRIMARY KEY AUTOINCREMENT,
    TicketId INTEGER NOT NULL,
    FileName TEXT NOT NULL,
    FilePath TEXT NOT NULL,
    UploadedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    UploadedBy INTEGER NOT NULL,
    FOREIGN KEY (TicketId) REFERENCES Tickets(Id),
    FOREIGN KEY (UploadedBy) REFERENCES Users(Id)
);

-- Comments table
CREATE TABLE Comments (
    Id INTEGER PRIMARY KEY AUTOINCREMENT,
    TicketId INTEGER NOT NULL,
    CommentText TEXT NOT NULL,
    CreatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CreatedBy INTEGER NOT NULL,
    FOREIGN KEY (TicketId) REFERENCES Tickets(Id),
    FOREIGN KEY (CreatedBy) REFERENCES Users(Id)
);

-- AuditTrail table
CREATE TABLE AuditTrail (
    Id INTEGER PRIMARY KEY AUTOINCREMENT,
    TicketId INTEGER NOT NULL,
    Action TEXT NOT NULL,
    Details TEXT,
    PerformedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PerformedBy INTEGER NOT NULL,
    FOREIGN KEY (TicketId) REFERENCES Tickets(Id),
    FOREIGN KEY (PerformedBy) REFERENCES Users(Id)
);