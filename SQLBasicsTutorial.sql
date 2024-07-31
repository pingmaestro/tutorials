/* Credit and thanks to @AlexTheAnalyst for the SQL Tutorial*/

DROP TABLE IF EXISTS EmployeeDemographics;

CREATE TABLE EmployeeDemographics (
    EmployeeID INT PRIMARY KEY, 
    FirstName  VARCHAR(50),
    LastName   VARCHAR(50),
    Age        INT,
    Gender     VARCHAR(50)
);

DROP TABLE IF EXISTS EmployeeSalary;

CREATE TABLE EmployeeSalary (
    EmployeeID INT,
    JobTitle VARCHAR(50),
    Salary INT
);

INSERT INTO EmployeeDemographics  VALUES
(1001, 'Jim', 'Halpert', 30, 'Male'),
(1002, 'Pam', 'Beasley', 30, 'Female'),
(1003, 'Dwight', 'Schrute', 29, 'Male'),
(1004, 'Angela', 'Martin', 31, 'Female'),
(1005, 'Toby', 'Flenderson', 32, 'Male'),
(1006, 'Michael', 'Scott', 35, 'Male'),
(1007, 'Meredith', 'Palmer', 32, 'Female'),
(1008, 'Stanley', 'Hudson', 38, 'Male'),
(1009, 'Kevin', 'Malone', 31, 'Male')

INSERT INTO EmployeeSalary VALUES
(1001, 'Salesman', 45000),
(1002, 'Receptionist', 36000),
(1003, 'Salesman', 63000),
(1004, 'Accountant', 47000),
(1005, 'HR', 50000),
(1006, 'Regional Manager', 65000),
(1007, 'Supplier Relations', 41000),
(1008, 'Salesman', 48000),
(1009, 'Accountant', 42000)

/*
SELECT Statement
TOP, DISTINCT, COUNT, AS, MAX, MIN, AVG
*/

SELECT TOP 5 *
FROM EmployeeDemographics

SELECT DISTINCT(Gender)
    FROM EmployeeDemographics

SELECT COUNT(LastName) AS 'Last Name Count'
    FROM EmployeeDemographics

SELECT AVG(Salary)
    FROM EmployeeSalary

SELECT *
    FROM SQLTutorial.dbo.EmployeeSalary

/* 
WHERE Statement
=, <>, <, >, AND, OR, LIKE, NULL, NOT NULL, IN
*/

SELECT *
    FROM EmployeeDemographics
    WHERE FirstName <> 'Jim'

SELECT *
    FROM EmployeeDemographics
    WHERE Age >= 30 AND Gender = 'Male'

SELECT *
    FROM EmployeeDemographics
    WHERE Age < 32 OR Gender = 'Female'

SELECT *
    FROM EmployeeDemographics
    WHERE LastName LIKE 's%o%'

SELECT *
    FROM EmployeeDemographics
    WHERE LastName LIKE '%s%'

SELECT *
    FROM EmployeeDemographics
    WHERE FirstName is NOT NULL

SELECT *
    FROM EmployeeDemographics
    WHERE FirstName IN ('Jim', 'Michael')

/* 
GROUP BY, ORDER BY
*/

SELECT *
    FROM EmployeeDemographics
    ORDER BY 4 DESC, 5 DESC

SELECT Gender, COUNT(Gender) AS 'Gender Count'
    FROM EmployeeDemographics
    WHERE Age > 31
    GROUP BY Gender
    ORDER BY Gender DESC