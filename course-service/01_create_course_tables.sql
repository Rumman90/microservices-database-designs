-- Target DB: CourseServiceDb

IF OBJECT_ID('dbo.Lectures', 'U') IS NOT NULL DROP TABLE dbo.Lectures;
IF OBJECT_ID('dbo.Courses', 'U') IS NOT NULL DROP TABLE dbo.Courses;
GO

CREATE TABLE dbo.Courses
(
    Id              BIGINT IDENTITY(1,1) CONSTRAINT PK_Courses PRIMARY KEY,
    Title           NVARCHAR(200)   NOT NULL,
    Slug            NVARCHAR(200)   NOT NULL,
    Description     NVARCHAR(MAX)   NULL,
    Level           NVARCHAR(50)    NULL,   -- e.g. Beginner, Intermediate, Advanced
    Language        NVARCHAR(50)    NULL,
    IsPublished     BIT             NOT NULL DEFAULT(0),

    -- Audit
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

CREATE UNIQUE INDEX UX_Courses_Slug_NotDeleted
ON dbo.Courses (Slug)
WHERE IsDeleted = 0;
GO

CREATE TABLE dbo.Lectures
(
    Id              BIGINT IDENTITY(1,1) CONSTRAINT PK_Lectures PRIMARY KEY,
    CourseId        BIGINT          NOT NULL,
    Title           NVARCHAR(200)   NOT NULL,
    VideoUrl        NVARCHAR(500)   NULL,
    DurationSeconds INT             NULL,
    Position        INT             NOT NULL, -- order in course

    -- Audit
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

ALTER TABLE dbo.Lectures
ADD CONSTRAINT FK_Lectures_Courses
    FOREIGN KEY (CourseId) REFERENCES dbo.Courses(Id);
GO

CREATE UNIQUE NONCLUSTERED INDEX UX_Lectures_CourseId_Position_NotDeleted
ON dbo.Lectures (CourseId, Position)
WHERE IsDeleted = 0;
GO
