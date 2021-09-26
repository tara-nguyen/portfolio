/********************************************
Database of student enrollment in Microsoft SQL Server

Project for the course Introduction to SQL at UCLA Extension

Completed in March 2021

********************************************/

-- ****************************
-- PART A
-- Create database
-- ****************************

USE Master;
GO
DROP DATABASE IF EXISTS schooldb;
GO
CREATE DATABASE schooldb;
GO
USE schooldb;

PRINT 'Part A Completed'

-- ****************************
-- PART B
-- Create and execute a stored procedure which executes a series of DROP TABLE
-- statements to remove all the tables created
-- ****************************

DROP PROCEDURE IF EXISTS usp_dropTables
GO
CREATE PROCEDURE usp_dropTables
AS
BEGIN
  DROP TABLE IF EXISTS CourseList
	DROP TABLE IF EXISTS ContactType
	DROP TABLE IF EXISTS EmpJobPosition
	DROP TABLE IF EXISTS Employees
	DROP TABLE IF EXISTS StudentInformation
	DROP TABLE IF EXISTS StudentContacts
	DROP TABLE IF EXISTS Student_Courses
END

-- Execute procedure
EXEC usp_dropTables
GO

PRINT 'Part B Completed'

-- ****************************
-- PART C
-- Define and create tables from the Entity Relationship Diagram
-- ****************************

DROP TABLE IF EXISTS StudentInformation
GO
CREATE TABLE StudentInformation (
  StudentID INT IDENTITY(100, 1),
  Title     CHAR(10) NULL,
  FirstName CHAR(10) NOT NULL,
  LastName CHAR(10) NOT NULL,
  Address1 CHAR(30) NULL,
  Address2 CHAR(30) NULL,
  City CHAR(20) NULL,
  County CHAR(20) NULL,
  Zip CHAR(5) NULL,
  Country CHAR(20) NULL,
  Telephone CHAR(15) NULL,
  Email CHAR(40) NULL,
  Enrolled CHAR NULL,
  AltTelephone CHAR(15) NULL
  CONSTRAINT PK_StudentInformation PRIMARY KEY (StudentID)
)

DROP TABLE IF EXISTS CourseList
GO
CREATE TABLE CourseList (
  CourseID INT IDENTITY(10, 1),
  CourseDescription CHAR(40) NOT NULL,
  CourseCost DECIMAL(7, 2) NULL,
  CourseDurationYears INT NULL,
  Notes CHAR(50) NULL,
  CONSTRAINT PK_CourseList PRIMARY KEY (CourseID)
)

DROP TABLE IF EXISTS Student_Courses
GO
CREATE TABLE Student_Courses (
  StudentCourseID INT IDENTITY(1, 1),
  StudentID INT NOT NULL,
  CourseID INT NOT NULL,
  CourseStartDate DATE NOT NULL,
  CourseComplete CHAR NULL,
  CONSTRAINT PK_StudentCourses PRIMARY KEY (StudentCourseID),
  CONSTRAINT FK_StudentCourses_Student
    FOREIGN KEY (StudentID) REFERENCES StudentInformation(StudentID),
  CONSTRAINT FK_StudentCourses_Course
    FOREIGN KEY (CourseID) REFERENCES CourseList(CourseID)
)

DROP TABLE IF EXISTS EmpJobPosition
GO
CREATE TABLE EmpJobPosition (
  EmpJobPositionID INT IDENTITY(1, 1),
  EmployeePosition CHAR(20) NOT NULL
  CONSTRAINT PK_EmpJobPosition PRIMARY KEY (EmpJobPositionID)
)

DROP TABLE IF EXISTS Employees
GO
CREATE TABLE Employees (
  EmployeeID INT IDENTITY(1000, 1),
  EmployeeName CHAR(25) NOT NULL,
  EmployeePositionID INT NOT NULL,
  EmployeePassword CHAR(15) NULL,
  Access CHAR(15) NULL,
  CONSTRAINT PK_Employees PRIMARY KEY (EmployeeID),
  CONSTRAINT FK_Employees_EmpJobPosition
    FOREIGN KEY (EmployeePositionID) REFERENCES EmpJobPosition(EmpJobPositionID)
)

DROP TABLE IF EXISTS ContactType
GO
CREATE TABLE ContactType (
  ContactTypeID INT IDENTITY(1, 1),
  ContactType CHAR(20) NOT NULL,
  CONSTRAINT PK_ContactType PRIMARY KEY (ContactTypeID)
)

DROP TABLE IF EXISTS StudentContacts
GO
CREATE TABLE StudentContacts (
  ContactID INT IDENTITY(10000, 1),
  StudentID INT NOT NULL,
  ContactTypeID INT NOT NULL,
  ContactDate DATE NOT NULL,
  EmployeeID INT NOT NULL,
  ContactDetails CHAR(50) NOT NULL,
  CONSTRAINT PK_StudentContacts PRIMARY KEY (ContactID),
  CONSTRAINT FK_StudentContacts_Student
    FOREIGN KEY (StudentID) REFERENCES StudentInformation(StudentID),
  CONSTRAINT FK_StudentContacts_ContactType
    FOREIGN KEY (ContactTypeID) REFERENCES ContactType(ContactTypeID),
  CONSTRAINT FK_StudentContacts_Employees
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID)
)

PRINT 'Part C Completed'

-- ****************************
-- PART D
-- Add columns, constraints, and indexes
-- ****************************

ALTER TABLE Student_Courses
ADD CONSTRAINT UC_StudentCourses UNIQUE (StudentID, CourseID)

ALTER TABLE StudentInformation
ADD CreatedDateTime DATETIME DEFAULT GETDATE()

ALTER TABLE StudentInformation
DROP COLUMN AltTelephone

DROP INDEX IF EXISTS StudentInformation.IX_LastName
GO
CREATE INDEX IX_LastName ON StudentInformation(LastName)

PRINT 'Part D Completed'

-- ****************************
-- PART E
-- Create and apply a trigger which automatically updates the Email field when a
--  new record is inserted into StudentInformation without that field specified
-- ****************************

DROP TRIGGER IF EXISTS trg_assignEmail
GO
CREATE TRIGGER trg_assignEmail ON StudentInformation
FOR INSERT
AS
UPDATE StudentInformation
SET Email = TRIM(FirstName) + '.' + TRIM(LastName) + '@disney.com'
WHERE EMAIL IS NULL;
GO

PRINT 'Part E Completed'

-- ****************************
-- Part F
-- Populate sample data
-- ****************************

INSERT INTO StudentInformation (FirstName, LastName)
VALUES ('Mickey', 'Mouse');

INSERT INTO StudentInformation (FirstName, LastName)
VALUES ('Minnie', 'Mouse');

INSERT INTO StudentInformation (FirstName, LastName)
VALUES ('Donald', 'Duck');

INSERT INTO CourseList (CourseDescription)
VALUES ('Advanced Math');

INSERT INTO CourseList (CourseDescription)
VALUES ('Intermediate Math');

INSERT INTO CourseList (CourseDescription)
VALUES ('Beginning Computer Science');

INSERT INTO CourseList (CourseDescription)
VALUES ('Advanced Computer Science');

INSERT INTO Student_Courses (StudentID, CourseID, CourseStartDate)
VALUES (100, 10, '01/05/2018');

INSERT INTO Student_Courses (StudentID, CourseID, CourseStartDate)
VALUES (101, 11, '01/05/2018');

INSERT INTO Student_Courses (StudentID, CourseID, CourseStartDate)
VALUES (102, 11, '01/05/2018');
INSERT INTO Student_Courses (StudentID, CourseID, CourseStartDate)
VALUES (100, 11, '01/05/2018');

INSERT INTO Student_Courses (StudentID, CourseID, CourseStartDate)
VALUES (102, 13, '01/05/2018');

INSERT INTO EmpJobPosition (EmployeePosition)
VALUES ('Math Instructor');

INSERT INTO EmpJobPosition (EmployeePosition)
VALUES ('Computer Science');

INSERT INTO Employees (EmployeeName, EmployeePositionID)
VALUES ('Walt Disney', 1);

INSERT INTO Employees (EmployeeName, EmployeePositionID)
VALUES ('John Lasseter', 2);

INSERT INTO Employees (EmployeeName, EmployeePositionID)
VALUES ('Danny Hillis', 2);

INSERT INTO ContactType (ContactType)
VALUES ('Tutor');

INSERT INTO ContactType (ContactType)
VALUES ('Homework Support');

INSERT INTO ContactType (ContactType)
VALUES ('Conference');

INSERT INTO StudentContacts (
  StudentID, ContactTypeID, EmployeeID, ContactDate, ContactDetails
)
VALUES (100, 1, 1000, '11/15/2017', 'Micky and Walt Math Tutoring');

INSERT INTO StudentContacts (
  StudentID, ContactTypeID, EmployeeID, ContactDate, ContactDetails
)
VALUES (101, 2, 1001, '11/18/2017', 'Minnie and John Homework support');

INSERT INTO StudentContacts (
  StudentID, ContactTypeID, EmployeeID, ContactDate, ContactDetails
)
VALUES (100, 3, 1001, '11/18/2017', 'Micky and Walt Conference');

INSERT INTO StudentContacts (
  StudentID, ContactTypeID, EmployeeID, ContactDate, ContactDetails
)
VALUES (102, 2, 1002, '11/20/2017', 'Donald and Danny Homework support');

INSERT INTO StudentInformation (FirstName, LastName, Email)
VALUES ('Porky', 'Pig', 'porky.pig@warnerbros.com');

INSERT INTO StudentInformation (FirstName, LastName)
VALUES ('Snow', 'White');

PRINT 'Part F Completed'

-- ****************************
-- PART G
-- Create and execute a stored procedure which allows for quick adds of Student
-- and Instructor contacts
-- ****************************

DROP PROCEDURE IF EXISTS usp_addQuickContacts
GO
CREATE PROCEDURE usp_addQuickContacts
@StudentEmail CHAR(40),
@EmployeeName CHAR(25),
@ContactDetails CHAR(50),
@ContactType CHAR(20)
AS
BEGIN
  -- Declare variables for student ID, employee ID, and contact type ID
	DECLARE @StudentID INT, @EmployeeID INT, @ContactTypeID INT
	-- Get student ID
	SELECT @StudentID = StudentID
	FROM StudentInformation
	WHERE Email = @StudentEmail
	-- Get employee ID
	SELECT @EmployeeID = EmployeeID
	FROM Employees
	WHERE EmployeeName = @EmployeeName
	-- Determine if the given contact type already exists in ContactType table
	-- If not then insert it as new record
	IF NOT EXISTS(
    SELECT ContactType FROM ContactType WHERE ContactType = @ContactType
  )
	INSERT INTO ContactType VALUES (@ContactType)
	-- Get contact type ID
	SELECT @ContactTypeID = ContactTypeID
	FROM ContactType
	WHERE ContactType = @ContactType
	-- Insert new record into StudentContacts
  INSERT INTO StudentContacts (
	  StudentID, EmployeeID, ContactDetails, ContactTypeID, ContactDate
	)
	VALUES (@StudentID, @EmployeeID, @ContactDetails, @ContactTypeID, GETDATE())
END
GO

-- Execute procedure
EXEC usp_addQuickContacts
'minnie.mouse@disney.com',
'John Lasseter',
'Minnie getting Homework Support from John',
'Homework Support'
EXEC usp_addQuickContacts
'porky.pig@warnerbros.com','John Lasseter',
'Porky studying with John for Test prep',
'Test Prep'

PRINT 'Part G Completed'

-- ****************************
-- PART H
-- Create and execute a stored procedure which takes a parameter,
-- CourseDescription, and returns a list of the students in the course,
-- displaying the following fields: FirstName, LastName, CourseDescription
-- ****************************

DROP PROCEDURE IF EXISTS usp_getCourseRosterByName
GO
CREATE PROCEDURE usp_getCourseRosterByName
@CourseDescription CHAR(40)
AS
SELECT CourseDescription, FirstName, LastName
FROM CourseList c
INNER JOIN Student_Courses sc
ON c.CourseID = sc.CourseID
INNER JOIN StudentInformation s
ON sc.StudentID = s.StudentID
WHERE CourseDescription = @CourseDescription
GO

-- Execute procedure
EXEC usp_getCourseRosterByName 'Intermediate Math'

PRINT 'Part H Completed'

-- ****************************
-- Part I
-- Create and select from a view which returns the results from StudentContacts,
-- displaying the following fields where contactType is Tutor:
-- EmployeeName, StudentName, ContactDetails, ContactDate
-- ****************************

DROP VIEW IF EXISTS vtutorContacts
GO
CREATE VIEW vTutorContacts
AS
SELECT
  EmployeeName,
	TRIM(FirstName) + ' ' + TRIM(LastName) as StudentName,
	ContactDetails,
	ContactDate
FROM StudentContacts sc
INNER JOIN Employees e
ON sc.EmployeeID = e.EmployeeID
INNER JOIN StudentInformation s
ON sc.StudentID = s.StudentID
INNER JOIN ContactType c
ON sc.ContactTypeID = c.ContactTypeID
WHERE ContactType = 'Tutor'
GO
SELECT * FROM vTutorContacts

PRINT 'Part I Completed'
