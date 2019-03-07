-- NAME: Mehedi Haque
-- ID: 154908172
-- DATE: Sept 07 2018
-- Purpose: Lab #1 DBS301
-----------------------------------------------------------------------

-- Q1: Used select satement for Employees, Department and Job history.
--     Also found which is longest and the widest table.

    SELECT * FROM employees;
    SELECT * FROM departments;
    SELECT * FROM job_history;
    
--The Employee table is the longest and widest as the table has most 
--rows and colums than the other two table.

--Q2: Fixed the select statement as it was missing an "as", and Hire
--    Date should be hire_date.

    SELECT last_name AS "LName", job_id AS "Job Title", 
    hire_date AS "Job Start"
    FROM EMPLOYEES;
    
--Q3: fixed the code errors like underscore was missing form last name, 
--  added AS for "Emp Com" and removed the extra comma 
--  between Select From satement.
        
        SELECT employee_id, last_name, commission_pct AS "Emp Comm"
        FROM employees;
        
--Q4: The DESC statement should show the structure of the Location Table
    DESC locations;


--Q5: Created a query to show the city#, city and province with Country Code

    SELECT location_id AS "CITY#", city AS "City",
    (state_province|| ' IN THE ' || country_id) AS
    "Province with Country Code"
    FROM locations;
    

    


