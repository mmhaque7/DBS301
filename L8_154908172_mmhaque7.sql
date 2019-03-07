-- ***********************
-- Name: Mehedi Haque
-- ID: 154908172
-- Date: November 11 2018
-- Purpose: Lab 8 DBS301
-- ***********************
--Q1--Display the names of the employees whose salary is the same as 
--the lowest salaried employee in any department.

SELECT first_name||','||last_name AS "Name"
    FROM employees
    WHERE salary =(SELECT MIN(salary)
                    FROM employees)
    ORDER BY "Name";
/*select first_name ,
        min(salary)
        from employees
        group by first_name
        order by MIN(salary);*/
--Q2 Display the names of the employee(s) whose salary 
--is the lowest in each department
SELECT first_name,last_name
    FROM employees e
    WHERE(salary)=( 
                        SELECT MIN(salary)
                        FROM employees
                        WHERE department_id = e.department_id
                 )
    ORDER BY last_name;            

--q3 Give each of the employees in question 2 a $100 bonus.
SELECT first_name,last_name, salary+100 AS "Bonus"
    FROM employees e
    WHERE(salary)=( 
                        SELECT MIN(salary)
                        FROM employees
                        WHERE department_id = e.department_id
                 )
    ORDER BY last_name;
--Q4-Create a view named ALLEMPS that consists of all employees 
--includes employee_id, last_name, salary, department_id, department_name, city and country (if applicable)
CREATE VIEW allemps AS
SELECT e.employee_id, e.last_name,e.salary, 
       department_id, d.department_name,
       l.city, c.country_name
    FROM employees e JOIN departments d USING(department_id)
    JOIN locations l USING (location_id)
    JOIN countries c USING(country_id);
--Q5---USING  allemps view
--a.Display the employee_id, last_name, salary and city for all employees
SELECT employee_id, last_name, salary, city
    FROM allemps;
--b--Display the total salary of all employees by city
SELECT city, SUM(salary)
    FROM allemps
    GROUP BY city;

--c.Increase the salary of the lowest paid employee(s) in each department by 100
UPDATE allemps
    SET salary = salary+100
    WHERE salary IN (SELECT salary FROM (SELECT min(salary) AS salary, department_id
    FROM allemps GROUP BY department_id))
    AND department_id IN (SELECT department_id FROM (SELECT min(salary) AS Salary, department_id
    FROM allemps GROUP BY department_id));
--d.What happens if you try to insert an employee by providing values for all columns in this view?
---INSERT INTO allemps VALUES
--(888, 'Reko ','Toronto', 'Canada' );
--does not get inserted!
--e.	Delete the employee named Vargas. Did it work? Show proof.
DELETE FROM allemps
    WHERE UPPER(last_name) = 'VARGAS';
--check
SELECT last_name
    FROM allemps
    WHERE UPPER(last_name)='VARGAS';

--6)	Create a view named ALLDEPTS that consists of all departments and includes 
--department_id, department_name, city and country (if applicable0
CREATE OR REPLACE VIEW  alldepts AS
SELECT department_id, department_name, city , country_name
    FROM departments
    JOIN locations USING(location_id)
    JOIN countries USING(country_id);
--Q7 - USING ALLDEPTS
--a.For all departments display the department_id, name and city
SELECT department_id, department_name , city
    FROM alldepts;
--b.For each city that has departments located in it display the number of departments by city
SELECT city, COUNT(department_id)
    FROM alldepts
    GROUP BY city;
--Q8 Create a view called ALLDEPTSUMM
CREATE OR REPLACE VIEW  alldeptsum AS
SELECT d.department_id,d.department_name,
       COUNT(e.employee_id) AS "Total Employees",
       COUNT(c.employee_id) AS "Salaried Employees",
       SUM(e.salary) AS "Total Salary"
    FROM departments d
        LEFT JOIN employees e ON d.department_id = e.department_id
        LEFT JOIN employees c ON e.employee_id = c.employee_id 
        AND c.commission_pct IS NULL
    GROUP BY d.department_id, d.department_name;

---9)	Use the ALLDEPTSUMM view to display department name and number of employees for departments that have more than the average number of employees 
SELECT department_name,"Total Employees"
    FROM alldeptsum
    WHERE "Total Employees" > (
                                SELECT AVG("Total Employees")
                                FROM alldeptsum
                                )
    ORDER BY department_name;

--10aUse the GRANT statement to allow another student (Neptune account) 
--to retrieve data for your employees table and to allow them to retrieve, insert and update data in your departments table. Show proof
GRANT 
SELECT ON employees TO Dbs301_183g18;
---
GRANT
SELECT,INSERT,UPDATE ON departments TO Dbs301_183g18;

--10bUse the REVOKE statement to remove permission for that student to 
--0insert and update data in your departments table
REVOKE INSERT,UPDATE ON departmens FROM Dbs301_183g18;

----END OF FILE--------










