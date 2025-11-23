-- Target DB: UserServiceDb

IF OBJECT_ID('dbo.UserRoles', 'U') IS NOT NULL DROP TABLE dbo.UserRoles;
IF OBJECT_ID('dbo.Roles', 'U') IS NOT NULL DROP TABLE dbo.Roles;
IF OBJECT_ID('dbo.Users', 'U') IS NOT NULL DROP TABLE dbo.Users;
GO

CREATE TABLE dbo.Users
(
    Id              BIGINT IDENTITY(1,1) CONSTRAINT PK_Users PRIMARY KEY,
    Email           NVARCHAR(256)    NOT NULL,
    PasswordHash    NVARCHAR(512)    NULL,  
    FirstName       NVARCHAR(100)    NULL,
    LastName        NVARCHAR(100)    NULL,
    PhoneNumber     NVARCHAR(50)     NULL,
    IsEmailVerified BIT              NOT NULL DEFAULT(0),
    IsActive        BIT              NOT NULL DEFAULT(1),

    -- Audit
    CreatedAt       DATETIME2(3)     NOT NULL DEFAULT SYSUTCDATETIME(),
    CreatedBy       NVARCHAR(100)    NULL,
    UpdatedAt       DATETIME2(3)     NULL,
    UpdatedBy       NVARCHAR(100)    NULL,

    -- Soft delete
    IsDeleted       BIT              NOT NULL DEFAULT(0),
    DeletedAt       DATETIME2(3)     NULL,
    DeletedBy       NVARCHAR(100)    NULL
);
GO

CREATE UNIQUE INDEX UX_Users_Email_NotDeleted
ON dbo.Users (Email)
WHERE IsDeleted = 0;
GO

CREATE TABLE dbo.Roles
(
    Id          INT IDENTITY(1,1) CONSTRAINT PK_Roles PRIMARY KEY,
    Name        NVARCHAR(100) NOT NULL,
    Description NVARCHAR(300) NULL,

    -- Audit
    CreatedAt   DATETIME2(3) NOT NULL DEFAULT SYSUTCDATETIME(),
    CreatedBy   NVARCHAR(100) NULL,
    UpdatedAt   DATETIME2(3) NULL,
    UpdatedBy   NVARCHAR(100) NULL,

    -- Soft delete
    IsDeleted   BIT NOT NULL DEFAULT(0),
    DeletedAt   DATETIME2(3) NULL,
    DeletedBy   NVARCHAR(100) NULL
);
GO

CREATE UNIQUE INDEX UX_Roles_Name_NotDeleted
ON dbo.Roles(Name)
WHERE IsDeleted = 0;
GO

CREATE TABLE dbo.UserRoles
(
    UserId      BIGINT NOT NULL,
    RoleId      INT    NOT NULL,

    -- Audit
    CreatedAt   DATETIME2(3) NOT NULL DEFAULT SYSUTCDATETIME(),
    CreatedBy   NVARCHAR(100) NULL,

    CONSTRAINT PK_UserRoles PRIMARY KEY (UserId, RoleId),

    CONSTRAINT FK_UserRoles_Users FOREIGN KEY (UserId) REFERENCES dbo.Users(Id),
    CONSTRAINT FK_UserRoles_Roles FOREIGN KEY (RoleId) REFERENCES dbo.Roles(Id)
);
GO

CREATE NONCLUSTERED INDEX IX_UserRoles_UserId ON dbo.UserRoles(UserId);
CREATE NONCLUSTERED INDEX IX_UserRoles_RoleId ON dbo.UserRoles(RoleId);
GO
