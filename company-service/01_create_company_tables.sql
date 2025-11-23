-- Target DB: CompanyServiceDb

IF OBJECT_ID('dbo.CompanyBranches', 'U') IS NOT NULL DROP TABLE dbo.CompanyBranches;
IF OBJECT_ID('dbo.Companies', 'U') IS NOT NULL DROP TABLE dbo.Companies;
GO

CREATE TABLE dbo.Companies
(
    Id              BIGINT IDENTITY(1,1) CONSTRAINT PK_Companies PRIMARY KEY,
    Name            NVARCHAR(200)    NOT NULL,
    LegalName       NVARCHAR(300)    NULL,
    RegistrationNo  NVARCHAR(100)    NULL,
    Country         NVARCHAR(100)    NULL,
    City            NVARCHAR(100)    NULL,
    WebsiteUrl      NVARCHAR(300)    NULL,
    IsActive        BIT              NOT NULL DEFAULT(1),

    -- Audit fields
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

CREATE TABLE dbo.CompanyBranches
(
    Id              BIGINT IDENTITY(1,1) CONSTRAINT PK_CompanyBranches PRIMARY KEY,
    CompanyId       BIGINT          NOT NULL,
    Name            NVARCHAR(200)   NOT NULL,
    AddressLine1    NVARCHAR(300)   NULL,
    AddressLine2    NVARCHAR(300)   NULL,
    City            NVARCHAR(100)   NULL,
    Country         NVARCHAR(100)   NULL,
    PhoneNumber     NVARCHAR(50)    NULL,
    IsHeadOffice    BIT             NOT NULL DEFAULT(0),
    IsActive        BIT             NOT NULL DEFAULT(1),

    -- Audit fields
    CreatedAt       DATETIME2(3)    NOT NULL DEFAULT SYSUTCDATETIME(),
    CreatedBy       NVARCHAR(100)   NULL,
    UpdatedAt       DATETIME2(3)    NULL,
    UpdatedBy       NVARCHAR(100)   NULL,

    -- Soft delete
    IsDeleted       BIT             NOT NULL DEFAULT(0),
    DeletedAt       DATETIME2(3)    NULL,
    DeletedBy       NVARCHAR(100)   NULL
);
GO

ALTER TABLE dbo.CompanyBranches
ADD CONSTRAINT FK_CompanyBranches_Companies
    FOREIGN KEY (CompanyId) REFERENCES dbo.Companies(Id);
GO

-- Helpful indexes
CREATE NONCLUSTERED INDEX IX_Companies_IsActive_IsDeleted
ON dbo.Companies (IsActive, IsDeleted);

CREATE NONCLUSTERED INDEX IX_CompanyBranches_CompanyId_IsDeleted
ON dbo.CompanyBranches (CompanyId, IsDeleted);
GO

