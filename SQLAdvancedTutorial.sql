/* Credit and thanks to @AlexTheAnalyst for the SQL Tutorial*/

/*
Common Table Expression (CTE)
*/

WITH CTE_Employee AS 
(SELECT FirstName, LastName, Gender, Salary
, COUNT(Gender) OVER (PARTITION BY Gender) as TotalGender
, AVG(Salary) OVER (PARTITION BY Gender) as AvgSalary
FROM SQLTutorial.dbo.EmployeeDemographics emp
JOIN SQLTutorial.dbo.EmployeeSalary sal
    ON emp.EmployeeID = sal.EmployeeID
WHERE Salary > 45000
)
SELECT FirstName, AvgSalary
FROM CTE_Employee

/*
Temporary Tables (Temp Tables) - valuable tool for handling large-scale data sets and manipulation tasks
*/

/*
CREATE TABLE #temp_Employee (
EmployeeID INT,
JobTitle VARCHAR(100),
Salary INT
)

SELECT *
FROM #temp_Employee

INSERT INTO #temp_Employee VALUES (
    '1001', 'HR', '45000'
)

INSERT INTO #temp_Employee
SELECT *
FROM SQLTutorial.dbo.EmployeeSalary
*/

DROP TABLE IF EXISTS #temp_Employee2
CREATE TABLE #temp_Employee2 (
JobTitle VARCHAR(50),
EmployeesPerJob INT,
AvgAge INT,
AvgSalary INT
)

INSERT INTO #temp_Employee2 
SELECT JobTitle, COUNT(JobTitle), AVG(Age), AVG(Salary)
FROM SQLTutorial.dbo.EmployeeDemographics emp
JOIN SQLTutorial.dbo.EmployeeSalary sal
    ON emp.EmployeeID = sal.EmployeeID
GROUP BY JobTitle

SELECT *
FROM #temp_Employee2

/* 
String Functions - TRIM, LTRI, RTRI, REPLACE, SUBSTRING, UPPER, LOWER
*/

DROP TABLE IF EXISTS EmployeeErrors
CREATE TABLE EmployeeErrors (
    EmployeeID VARCHAR(50),
    FirstName VARCHAR(50),
    LastName VARCHAR(50)
)

INSERT INTO EmployeeErrors VALUES 
('1001  ', 'Jimbo', 'Halbert')
,('  1002', 'Pamela', 'Beasely')
,('1005', 'TOby', 'Flenderson - Fired')

SELECT *
FROM SQLTutorial.dbo.EmployeeErrors

-- USING TRIM

SELECT EmployeeID, TRIM(EmployeeID) AS IDTRIM
FROM SQLTutorial.dbo.EmployeeErrors

SELECT EmployeeID, LTRIM(EmployeeID) AS IDTRIM
FROM SQLTutorial.dbo.EmployeeErrors

SELECT EmployeeID, RTRIM(EmployeeID) AS IDTRIM
FROM SQLTutorial.dbo.EmployeeErrors

-- USING REPLACE

SELECT LastName, REPLACE(LastName, '- Fired', '') AS LastNameFixed
FROM SQLTutorial.dbo.EmployeeErrors

-- USING SUBSTRING / FUZZY MATCHING

/*
INSERT INTO EmployeeDemographics VALUES
(1005, 'Toby', 'Flenderson', 32, 'Male')
*/

SELECT SUBSTRING(FirstName,1 ,3 )
FROM SQLTutorial.dbo.EmployeeErrors

SELECT err.FirstName,SUBSTRING(err.FirstName, 1,3), dem.FirstName, SUBSTRING(dem.FirstName,1,3)
FROM SQLTutorial.dbo.EmployeeErrors err
JOIN SQLTutorial.dbo.EmployeeDemographics dem
    ON SUBSTRING(err.FirstName,1,3) = SUBSTRING(dem.FirstName,1,3)
/* To have a high accuracy on a fuzz match it would require more infos such as :
-- Gender
-- Last Name
-- Age
-- Date of Birth
*/

-- Using UPPER and LOWER

SELECT FirstName, LOWER(FirstName)
FROM EmployeeErrors

SELECT LastName, UPPER(LastName)
FROM EmployeeErrors

/* 
Stored Procedures 
*/

-- Let's start simple!

CREATE PROCEDURE TEST
AS
SELECT *
FROM EmployeeDemographics

EXEC TEST

-- Let's increase the scope!

CREATE PROCEDURE Temp_Employee AS
DROP TABLE IF EXISTS #temp_Employee2
CREATE TABLE #temp_Employee2 (
JobTitle VARCHAR(50),
EmployeesPerJob INT,
AvgAge INT,
AvgSalary INT
)

INSERT INTO #temp_Employee2 
SELECT JobTitle, COUNT(JobTitle), AVG(Age), AVG(Salary)
FROM SQLTutorial.dbo.EmployeeDemographics emp
JOIN SQLTutorial.dbo.EmployeeSalary sal
    ON emp.EmployeeID = sal.EmployeeID
GROUP BY JobTitle

SELECT *
FROM #temp_Employee2

EXEC Temp_Employee @JobTitle = 'Salesman'

/* 
SUBQUERIES or Nested queries (in the SELECT, FROM, and WHERE Statement)
*/


SELECT *
FROM EmployeeSalary

-- Subquery in SELECT

SELECT EmployeeID, Salary, (SELECT AVG(Salary) FROM EmployeeSalary) AS AllAvgSalary
FROM EmployeeSalary

-- How to do it with PARTITION by
SELECT EmployeeID, Salary, AVG(Salary) OVER() AS AllAvgSalary
FROM EmployeeSalary

-- Why GROUP BY is not the way to go

SELECT EmployeeID, Salary, AVG(Salary) AS AllAvgSalary
FROM EmployeeSalary
GROUP BY EmployeeID, Salary
ORDER BY 1,2

-- Subquery in FROM

SELECT a.EmployeeID, AllAvgSalary
FROM (  SELECT EmployeeID, Salary, AVG(Salary) OVER() AS AllAvgSalary
        FROM EmployeeSalary) a

-- Subquery in WHERE

SELECT EmployeeID, JobTitle, Salary
FROM EmployeeSalary
WHERE EmployeeID in (
	SELECT EmployeeID
	FROM EmployeeDemographics
    WHERE Age > 30
    )