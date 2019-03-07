-- ***********************
-- Name: Mehedi Haque
-- ID: 154908172
-- Date: November 5, 2018
-- Purpose: Lab 7 DBS301--

--Q1.	The HR department needs a list of Department IDs for departments 
--that do not conbtain the job ID of ST_CLERK

SELECT department_id
    FROM departments
    MINUS 
SELECT department_id
    FROM employees
    WHERE UPPER(job_id) = 'ST_CLERK';

--Q2-Same department requests a list of countries that have no departments located in them. 
--Display country ID and the country name
SELECT country_id,country_name
    FROM countries
    MINUS
SELECT c.country_id, c.country_name
FROM countries c
    JOIN locations l
    ON(c.country_id = l.country_id)
    JOIN departments d
    ON(d.location_id = l.location_id)
    WHERE department_id IS NOT NULL;

--q3 The Vice President needs very quickly a list of departments 
--10, 50, 20 in that order. job and department ID are to be displayed.
SELECT DISTINCT job_id, department_id
    FROM employees
    WHERE department_id = 10
    UNION ALL
SELECT DISTINCT job_id, department_id
    FROM employees
    WHERE department_id = 50
    UNION ALL
SELECT DISTINCT job_id, department_id
    FROM employees
    WHERE department_id = 20;
--q4--Create a statement that lists the employeeIDs and JobIDs of those employees who currently have a job title 
--that is the same as their job title when they were initially hired by the company
SELECT employee_id, job_id
    FROM employees
    INTERSECT
SELECT employee_id,job_id
    FROM job_history;
--q5--a.	Last name and department ID of all employees regardless of whether they belong to a department or not.
--b.	Department ID and department name of all departments regardless of whether they have employees in them or not.
SELECT last_name, department_id, TO_CHAR('null') AS "JOB" 
    FROM employees
    UNION
SELECT TO_CHAR('null'), department_id, department_name -- same as above
    FROM departments;

