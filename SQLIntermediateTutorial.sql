/* Credit and thanks to @AlexTheAnalyst for the SQL Tutorial*/

/*
INSERT INTO SQLTutorial.dbo.EmployeeDemographics VALUES
(1011, 'Ryan', 'Howard', 26, 'Male'),
(NULL, 'Holly', 'Flax', NULL, NULL),
(1013, 'Darryl', 'Philbin', NULL, 'Male')

INSERT INTO SQLTutorial.dbo.EmployeeSalary VALUES
(1010,  NULL, 47000),
(NULL, 'Salesman', 43000)

CREATE TABLE WareHouseEmployeeDemographics (
    EmployeeID INT, 
    FirstName VARCHAR(50), 
    LastName VARCHAR(50), 
    Age INT, 
    Gender VARCHAR(50)
)
INSERT INTO WareHouseEmployeeDemographics VALUES
(1013, 'Darryl', 'Philbin', NULL, 'Male'),
(1050, 'Roy', 'Anderson', 31, 'Male'),
(1051, 'Hidetoshi', 'Hasagawa', 40, 'Male'),
(1052, 'Val', 'Johnson', 31, 'Female')
*/


/*
INNER JOINS, FULL/LEFT/RIGHT OUTER JOINS
*/

SELECT *
FROM SQLTutorial.dbo.EmployeeDemographics

SELECT *
FROM SQLTutorial.dbo.EmployeeSalary

SELECT *
FROM SQLTutorial.dbo.EmployeeDemographics d
INNER JOIN SQLTutorial.dbo.EmployeeSalary s 
    ON d.EmployeeID = s.EmployeeID

SELECT s.EmployeeID, FirstName, LastName, JobTitle, Salary
FROM SQLTutorial.dbo.EmployeeDemographics d
LEFT OUTER JOIN SQLTutorial.dbo.EmployeeSalary s 
    ON d.EmployeeID = s.EmployeeID

SELECT d.EmployeeID, FirstName, LastName, Salary
FROM SQLTutorial.dbo.EmployeeDemographics d
INNER JOIN SQLTutorial.dbo.EmployeeSalary s 
    ON d.EmployeeID = s.EmployeeID
WHERE FirstName <> 'Michael'
ORDER BY Salary DESC

SELECT JobTitle, AVG(Salary)
FROM SQLTutorial.dbo.EmployeeDemographics d
INNER JOIN SQLTutorial.dbo.EmployeeSalary s 
    ON d.EmployeeID = s.EmployeeID
WHERE JobTitle = 'Salesman'
GROUP BY JobTitle

/*
UNION, UNION ALL
*/

SELECT *
FROM SQLTutorial.dbo.EmployeeDemographics d
FULL OUTER JOIN SQLTutorial.dbo.WareHouseEmployeeDemographics w
    ON d.EmployeeID = w.EmployeeID

SELECT *
FROM SQLTutorial.dbo.EmployeeDemographics d
UNION
SELECT *
FROM SQLTutorial.dbo.WareHouseEmployeeDemographics w

SELECT *
FROM SQLTutorial.dbo.EmployeeDemographics d
UNION ALL
SELECT *
FROM SQLTutorial.dbo.WareHouseEmployeeDemographics w
ORDER BY EmployeeID

SELECT EmployeeID, FirstName, Age
FROM SQLTutorial.dbo.EmployeeDemographics d
UNION
SELECT EmployeeID, JobTitle, Salary
FROM SQLTutorial.dbo.EmployeeSalary s
ORDER BY EmployeeID

/*
CASE Statements
*/

SELECT FirstName, LastName, Age,
CASE
    WHEN Age > 30 THEN 'Old'
    WHEN Age BETWEEN 27 AND 30 THEN 'Young'
    ELSE 'Baby'
END
FROM SQLTutorial.dbo.EmployeeDemographics d
WHERE Age IS NOT NULL
ORDER BY Age

SELECT FirstName, LastName, JobTitle, Salary,
CASE
    WHEN JobTitle = 'Salesman' THEN Salary + (Salary * .10)
    WHEN JobTitle = 'Accountant' THEN Salary + (Salary * .05)
    WHEN JobTitle = 'HR' THEN Salary + (Salary * .000001)
    ELSE Salary +(Salary * 0.03)
END AS 'Salary After Raise'
FROM SQLTutorial.dbo.EmployeeDemographics d
JOIN SQLTutorial.dbo.EmployeeSalary s
    ON d.EmployeeID = s.EmployeeID


/*
HAVING Clause
*/

SELECT JobTitle, COUNT(JobTitle)
FROM SQLTutorial.dbo.EmployeeDemographics d
JOIN SQLTutorial.dbo.EmployeeSalary s
    ON d.EmployeeID = s.EmployeeID
GROUP BY JobTitle
HAVING COUNT(JobTitle) > 1

SELECT JobTitle, AVG(Salary)
FROM SQLTutorial.dbo.EmployeeDemographics d
JOIN SQLTutorial.dbo.EmployeeSalary s
    ON d.EmployeeID = s.EmployeeID
GROUP BY JobTitle
HAVING AVG(Salary) > 45000
ORDER BY AVG(Salary)

/*
UPDATING/DELETING DATA
*/

SELECT *
    FROM SQLTutorial.dbo.EmployeeDemographics

UPDATE SQLTutorial.dbo.EmployeeDemographics
SET EmployeeID = 1012
WHERE FirstName = 'Holly' AND LastName = 'Flax'

UPDATE SQLTutorial.dbo.EmployeeDemographics
SET Age = 31, Gender = 'Female'
WHERE FirstName = 'Holly' AND LastName = 'Flax'

SELECT *
/*DELETE*/ FROM SQLTutorial.dbo.EmployeeDemographics
WHERE EmployeeID = 1004

/*
ALIASING
*/

SELECT FirstName + ' ' + LastName AS 'Full Name'
FROM [SQLTutorial].[dbo].[EmployeeDemographics]

SELECT AVG(Age) AS 'Average Age'
FROM [SQLTutorial].[dbo].[EmployeeDemographics]

SELECT Demo.EmployeeID
FROM [SQLTutorial].[dbo].[EmployeeDemographics] Demo
JOIN [SQLTutorial].[dbo].[EmployeeSalary] Sal
    ON Demo.EmployeeID = Sal.EmployeeID

SELECT Demo.EmployeeID, Demo.FirstName, Demo.FirstName,
    Sal.JobTitle, Ware.Age
FROM [SQLTutorial].[dbo].[EmployeeDemographics] Demo
LEFT JOIN [SQLTutorial].[dbo].[EmployeeSalary] Sal
    ON Demo.EmployeeID = Sal.EmployeeID
LEFT JOIN [SQLTutorial].[dbo].[WareHouseEmployeeDemographics] Ware
    ON Demo.EmployeeID = Ware.EmployeeID
    
/*
PARTITION BY VS GROUP BY
*/

SELECT FirstName, LastName, Gender, Salary
, COUNT(Gender) OVER (PARTITION BY Gender) AS 'Total Gender'
FROM SQLTutorial.dbo.EmployeeDemographics dem
JOIN SQLTutorial.dbo.EmployeeSalary sal
    ON dem.EmployeeID = sal.EmployeeID

SELECT Gender, COUNT(Gender) 
FROM SQLTutorial.dbo.EmployeeDemographics dem
JOIN SQLTutorial.dbo.EmployeeSalary sal
    ON dem.EmployeeID = sal.EmployeeID
GROUP BY Gender

