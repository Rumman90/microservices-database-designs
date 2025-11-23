DECLARE @TestCompA BIGINT, @TestCompB BIGINT;

------------------------------------
-- Insert Test Companies
------------------------------------

INSERT INTO dbo.Companies (Name, LegalName, RegistrationNo, Country, City, WebsiteUrl, CreatedBy)
VALUES 
('TestCompanyA', 'TestCompanyA Legal Entity', 'TCA-0001', 'TestLand', 'TestCityA', 'https://testcompanyA.local', 'seed');

SET @TestCompA = SCOPE_IDENTITY();

INSERT INTO dbo.Companies (Name, LegalName, RegistrationNo, Country, City, WebsiteUrl, CreatedBy)
VALUES 
('TestCompanyB', 'TestCompanyB Legal Entity', 'TCB-0002', 'TestLand', 'TestCityB', 'https://testcompanyB.local', 'seed');

SET @TestCompB = SCOPE_IDENTITY();


------------------------------------
-- Insert Test Branches
------------------------------------

INSERT INTO dbo.CompanyBranches (CompanyId, Name, City, Country, IsHeadOffice, CreatedBy)
VALUES
(@TestCompA, 'TestCompanyA_HQ', 'TestCityA', 'TestLand', 1, 'seed'),
(@TestCompA, 'TestCompanyA_Branch1', 'TestCityA1', 'TestLand', 0, 'seed'),

(@TestCompB, 'TestCompanyB_HQ', 'TestCityB', 'TestLand', 1, 'seed'),
(@TestCompB, 'TestCompanyB_Branch1', 'TestCityB1', 'TestLand', 0, 'seed');
