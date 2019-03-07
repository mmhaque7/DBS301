-- ***********************
-- Name: Md Mehedi Haque
-- ID: 154908172
-- Date: Oct, 10 2018
-- Purpose: Lab 5 DBS301
-- ***********************

--Part A--simple joins!
--Q1--display the department name, city, street address and postal code 
--for departments sorted by city and department name.

SELECT 
        department_name AS "Department",
        city AS "City",
        street_address AS "Street Address",
        postal_code AS "Postal Code"
    FROM departments d JOIN locations l
    ON d.location_id  = l.location_id
    ORDER BY city , department_name;

--Q2--display full name of the employees, hire date, salary, department
--name and city. Department name only starting wth A or S. Sorted by
--department name and employee name.
SELECT
        last_name||', '||first_name AS "Full Name",
        hire_date AS "Hire Date",
        TO_CHAR(salary, '$999,999.99')AS "Salary",
        department_name AS "Department",
        city AS "City"
    FROM employees e JOIN departments d
        ON e.department_id =  d.department_id
    JOIN locations l 
        ON d.location_id = l.location_id
    WHERE UPPER(department_name) LIKE 'A%' OR
          UPPER(department_name) LIKE 'S%'
    ORDER BY department_name, "Full Name";

--Q3--dispaly full name of manager of each departments in the State/province along with department
--name,city,postal code and province name.
SELECT
        last_name||', '||first_name AS "Full Name",
        department_name AS "Department",
        city AS "City",
        postal_code AS "Postal Code",
        state_province AS "State/Province"
    FROM departments d JOIN employees e ON d.manager_id = e.employee_id
        JOIN locations l ON d.location_id = l.location_id
    WHERE state_province IN ('Ontario','California','Washington')
    ORDER BY city, department_name;
--Q4--display employee last name, employee number, manager last name and manager number
SELECT
        e.last_name AS "Employee",
        e.employee_id AS "Emp#",
        m.last_name AS "Manager",
        m.employee_id AS "Mgr#"
    FROM employees e JOIN employees m ON e.manager_id = m.employee_id;
--PART B-- NON-Simple Joins
--Q5--display department name,city,street address,postal code and country name for all Departments
SELECT
        department_name AS "Department",
        city AS "City",
        street_address AS "Street Address",
        country_name "Country Name"
    FROM departments d LEFT JOIN locations l USING(location_id)
        LEFT JOIN countries USING(country_id)
    ORDER BY department_name DESC;
--Q6--Display full name of employee,hired date, salary and department name where deparments starts with A or S
SELECT
        first_name||' / '||last_name AS "Full Name",
        hire_date AS "Hire Date",
        TO_CHAR(salary,'$999,999.99') AS "Salary",
        department_name AS "Department"
    FROM employees e LEFT JOIN departments d ON e.department_id = d.department_id
    WHERE UPPER(department_name) LIKE 'A%' OR
          UPPER(department_name) LIKE 'S%'
    ORDER BY department_name, last_name;
--Q7--dispaly the full name of the manager of each departments in Ontario, California and Washinton. dispaly
--department name, postal code and province name.
SELECT 
        last_name || ', ' || e.first_name AS "Full Name", 
        department_name AS "Department",
        city AS "City", 
        postal_code AS "Postal Code", 
        state_province AS "State/Province"
    FROM employees e INNER JOIN departments d ON e.manager_id = d.manager_id
         INNER JOIN locations l ON l.location_id = d.location_id
    WHERE state_province IN ('Ontario', 'California', 'Washington')
    ORDER BY city, department_name;
--Q8--display department name, highest, lowest, average pay in each deapartment.
SELECT 
        department_name, 
        TO_CHAR(max(salary), '$999,999.99') AS "High", 
        TO_CHAR(min(salary), '$999,999.99') AS "Low", 
        TO_CHAR(avg(salary), '$999,999.99') AS "Avg."
    FROM employees e INNER JOIN departments d ON d.department_id = e.department_id
GROUP BY department_name
ORDER BY avg(salary) DESC;
--Q9--Display employee last name, empployee number, manager name(last) , manager number
SELECT 
        e.last_name AS "Employee" , 
        e.employee_id AS "Emp#", 
        m.last_name AS "Manager", 
        m.employee_id AS "Mgr#"
    FROM employees e FULL JOIN employees m USING(manager_id);
----END OF FILE----