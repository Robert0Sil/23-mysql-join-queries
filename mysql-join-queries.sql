-- 1 Write a query to get the department name and number of employees
--   in the department.

SELECT Employees.DEPARTMENT_ID, Departments.DEPARTMENT_NAME,
    COUNT(Employees.EMPLOYEE_ID) AS NUM_EMPLOYEES
FROM Employees

INNER JOIN Departments
ON Employees.DEPARTMENT_ID = Departments.DEPARTMENT_ID
GROUP BY DEPARTMENT_ID;


-- 2 Write a query to find the employee ID, job title, number of days
--   between ending date and starting date for all jobs in department 90
--   from job history.

SELECT Employees.EMPLOYEE_ID, Employees.FIRST_NAME, Employees.LAST_NAME,
    Jobs.JOB_TITLE, Departments.DEPARTMENT_NAME,
    (JobHistory.END_DATE - JobHistory.START_DATE) AS NUM_DAYS
FROM Employees
INNER JOIN Jobs
ON Employees.JOB_ID = Jobs.JOB_ID
INNER JOIN Departments
ON Employees.DEPARTMENT_ID = Departments.DEPARTMENT_ID
INNER JOIN JobHistory
ON Employees.JOB_ID = JobHistory.JOB_ID
WHERE JobHistory.DEPARTMENT_ID = 90;


-- 3 Write a query to display the department ID and name and first name of manager.

SELECT Departments.DEPARTMENT_ID, Departments.DEPARTMENT_NAME,
    Employees.FIRST_NAME, Employees.LAST_NAME
FROM Departments
INNER JOIN Employees
ON Employees.DEPARTMENT_ID = Departments.DEPARTMENT_ID
WHERE Employees.EMPLOYEE_ID = Departments.MANAGER_ID;


-- 4 Write a query to display the department name, manager name, and city.

SELECT Departments.DEPARTMENT_NAME,
    Employees.FIRST_NAME, Employees.LAST_NAME,
    Locations.CITY
FROM Departments
INNER JOIN Locations
ON Locations.LOCATION_ID = Departments.LOCATION_ID
INNER JOIN Employees
ON Employees.DEPARTMENT_ID = Departments.DEPARTMENT_ID
WHERE Employees.EMPLOYEE_ID = Departments.MANAGER_ID;

-- 5 Write a query to display the job title and average salary of employees.

SELECT Jobs.JOB_TITLE, AVG(Employees.SALARY) AS PROM_SALARY
FROM Jobs
INNER JOIN Employees
ON Employees.JOB_ID = Jobs.JOB_ID
GROUP BY Jobs.JOB_TITLE;


-- 6 Write a query to display job title, employee name, and the difference
--  between salary of the employee and minimum salary for the job.

SELECT Jobs.JOB_TITLE, Employees.FIRST_NAME, Employees.LAST_NAME,
    # --Employees.SALARY, Jobs.MIN_SALARY,
    (Employees.SALARY - Jobs.MIN_SALARY) AS DIFFERENCE_SALARY
FROM Jobs
INNER JOIN Employees
ON Employees.JOB_ID = Jobs.JOB_ID;


-- 7 Write a query to display the job history of any employee who
--  is currently drawing more than 10000 of salary.

SELECT Departments.DEPARTMENT_NAME,
    Employees.FIRST_NAME, Employees.LAST_NAME,
    Locations.CITY, JobHistory.START_DATE, JobHistory.END_DATE, Jobs.JOB_TITLE
FROM JobHistory
INNER JOIN Departments
ON Departments.DEPARTMENT_ID = JobHistory.DEPARTMENT_ID
INNER JOIN Locations
ON Locations.LOCATION_ID = Departments.LOCATION_ID
INNER JOIN Employees
ON Employees.EMPLOYEE_ID = JobHistory.EMPLOYEE_ID
INNER JOIN Jobs
ON Jobs.JOB_ID = JobHistory.JOB_ID
WHERE Employees.SALARY > 10000;


-- 8 Write a query to display department name, full name (first_name, last_name),
--    hire date, salary of the manager for all managers whose experience
--    is more than 15 years.

SELECT Departments.DEPARTMENT_NAME,
    Employees.FIRST_NAME, Employees.LAST_NAME, Employees.HIRE_DATE,
    Locations.CITY
FROM Employees
INNER JOIN Departments
ON Employees.DEPARTMENT_ID = Departments.DEPARTMENT_ID
INNER JOIN Locations
ON Locations.LOCATION_ID = Departments.LOCATION_ID

WHERE DATE_SUB(CURDATE(), INTERVAL 15 YEAR) >= Employees.HIRE_DATE
AND Employees.EMPLOYEE_ID IN (SELECT DISTINCT MANAGER_ID FROM Departments);


--fin
