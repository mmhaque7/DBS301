-- ***********************
-- Name: Md Mehedi Haque
-- ID: 154908172
-- Date: Oct, 13 2018
-- Purpose: Lab 6 DBS301
-- ***********************
--Q1- seting autocommit on
SET AUTOCOMMIT ON;

--Q2--create an Insert myself with a NULL salary,0.2 commision,
--in department 90, and manager 100. I started today.
INSERT INTO employees(employee_id, first_name, 
            last_name, salary, commission_pct, department_id, 
            manager_id, hire_date, email, job_id)
VALUES (420 ,'Mehedi', 'Haque', NULL, 0.2, 90, 100, sysdate, 'mehedi@boss.com', 111);

--Q3 update the salary of employees with the last name Matos and Whalen
--to 2500.
UPDATE employees
SET salary = 2500
WHERE UPPER(last_name) ='MATOS' OR UPPER(last_name) = 'WHALEN';
--Q4--display the last names of all employees who are in the same
--department named Abel
SELECT last_name 
    FROM employees
    WHERE department_id IN(
        SELECT department_id
            FROM employees
            WHERE UPPER(last_name) = 'ABEL'
    );
--Q5--display the last name of the lowest paid employees
SELECT Last_name AS "Last Name"
    FROM employees
    WHERE salary IN (
        SELECT MIN(salary)
        FROM employees
    );

--Q6--display the city that the lowest paid employees are located 
SELECT city AS "City"
    FROM employees INNER JOIN departments USING(department_id) INNER JOIN locations USING(location_id)
    WHERE salary = (Select MIN(salary)
                    FROM employees
                    );
--Q7--Display the last name, department_id, and salary of the lowest paid employee(s) in each department.  
--Sort by Department_ID.
Select last_name AS "Last Name",
        department_id AS "Department",
        TO_CHAR(salary,'$999,999.99') AS "Salary"
    FROM  employees a 
    WHERE salary = (
        SELECT MIN(salary)
        FROM employees e
        where e.department_id = a.department_id
    )
    ORDER BY department_id;
--Q8--Display the last name of the lowest paid employee(s) in each city
SELECT DISTINCT last_name, l.city
    FROM employees e INNER JOIN departments d ON(e.department_id = d.department_id) 
        INNER JOIN locations l ON (l.location_id = d.location_id)
    WHERE salary IN (SELECT min(salary)
    FROM employees emp INNER JOIN departments dep 
    ON(emp.department_id = dep.department_id) 
    INNER JOIN locations loc ON(loc.location_id = dep.location_id)
    WHERE d.location_id = dep.location_id);
--Q9--Display last name and salary for all employees 
--who earn less than the lowest salary in ANY department.  
--Sort the output by top salaries first and then by last name.
SELECT last_name AS "Last Name",
        TO_CHAR(salary,'$999,999.99') AS "Salary"
    FROM employees
    WHERE salary < ANY(SELECT MIN(salary)
                        FROM employees
                        GROUP BY department_id)
    ORDER BY salary DESC, last_name;
--Q10--10.	Display last name, job title and salary for all 
--employees whose salary matches any of the salaries from the IT Department. Do NOT use Join method
SELECT last_name AS "Last Name",
        job_id AS "Job ID",
        TO_CHAR(salary,'$999,999.99') AS "Salary"
    FROM employees
    WHERE salary = ANY(select salary
                        FROM employees
                        WHERE department_id IN(SELECT department_id
                                                FROM departments
                                                WHERE UPPER(department_name)='IT')
                                                )
    ORDER BY salary, last_name;
----END OF FILE-----------
