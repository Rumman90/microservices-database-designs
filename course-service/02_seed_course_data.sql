DECLARE @CourseA BIGINT, @CourseB BIGINT;

------------------------------------
-- Insert Test Courses
------------------------------------

INSERT INTO dbo.Courses (Title, Slug, Description, Level, Language, IsPublished, CreatedBy)
VALUES
('TestCourseA', 'test-course-a',
 'Test course A description for testing LMS module.',
 'TestLevelA', 'TestLang', 1, 'seed');
SET @CourseA = SCOPE_IDENTITY();

INSERT INTO dbo.Courses (Title, Slug, Description, Level, Language, IsPublished, CreatedBy)
VALUES
('TestCourseB', 'test-course-b',
 'Test course B description for testing LMS module.',
 'TestLevelB', 'TestLang', 0, 'seed');
SET @CourseB = SCOPE_IDENTITY();


------------------------------------
-- Insert Test Lectures
------------------------------------

INSERT INTO dbo.Lectures (CourseId, Title, DurationSeconds, Position, CreatedBy)
VALUES
(@CourseA, 'TestCourseA_Lecture1', 600, 1, 'seed'),
(@CourseA, 'TestCourseA_Lecture2', 800, 2, 'seed'),
(@CourseA, 'TestCourseA_Lecture3', 900, 3, 'seed'),

(@CourseB, 'TestCourseB_Lecture1', 700, 1, 'seed'),
(@CourseB, 'TestCourseB_Lecture2', 850, 2, 'seed'),
(@CourseB, 'TestCourseB_Lecture3', 950, 3, 'seed');
