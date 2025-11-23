DECLARE @RoleA INT, @RoleB INT, @RoleC INT;
DECLARE @UserA BIGINT, @UserB BIGINT, @UserC BIGINT;

------------------------------------
-- Insert Test Roles
------------------------------------

INSERT INTO dbo.Roles (Name, Description, CreatedBy)
VALUES ('TestRoleA', 'Test role for admin-like permissions', 'seed');
SET @RoleA = SCOPE_IDENTITY();

INSERT INTO dbo.Roles (Name, Description, CreatedBy)
VALUES ('TestRoleB', 'Test role for dev-like permissions', 'seed');
SET @RoleB = SCOPE_IDENTITY();

INSERT INTO dbo.Roles (Name, Description, CreatedBy)
VALUES ('TestRoleC', 'Test role for read-only permissions', 'seed');
SET @RoleC = SCOPE_IDENTITY();


------------------------------------
-- Insert Test Users
------------------------------------

INSERT INTO dbo.Users (Email, FirstName, LastName, IsEmailVerified, CreatedBy)
VALUES ('testuserA@test.local', 'TestUserA_First', 'TestUserA_Last', 1, 'seed');
SET @UserA = SCOPE_IDENTITY();

INSERT INTO dbo.Users (Email, FirstName, LastName, IsEmailVerified, CreatedBy)
VALUES ('testuserB@test.local', 'TestUserB_First', 'TestUserB_Last', 1, 'seed');
SET @UserB = SCOPE_IDENTITY();

INSERT INTO dbo.Users (Email, FirstName, LastName, IsEmailVerified, CreatedBy)
VALUES ('testuserC@test.local', 'TestUserC_First', 'TestUserC_Last', 0, 'seed');
SET @UserC = SCOPE_IDENTITY();


------------------------------------
-- Map Users to Test Roles
------------------------------------

INSERT INTO dbo.UserRoles (UserId, RoleId, CreatedBy)
VALUES
(@UserA, @RoleA, 'seed'),
(@UserB, @RoleB, 'seed'),
(@UserC, @RoleC, 'seed');
