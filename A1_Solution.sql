-- *****************************************************************************
-- Name: Jeffrey Espiritu
-- ID: 058316092
-- Name: Mahmoud Ghazizadeh
-- ID: 052593134
-- Date: June 19, 2018
-- Purpose: Assignment 1 DBS301
-- *****************************************************************************

-- Q1. Display employees hired in May and November and show the date in a
-- specific format.
SELECT employee_id, SUBSTR(last_name || ', ' || first_name, 1, 25) AS "Full Name",
    job_id, TO_CHAR(LAST_DAY(hire_date), 'fm[Month DDth "of" YYYY]') AS "Start Date"
    FROM employees
    WHERE EXTRACT(MONTH FROM hire_date) IN (5, 11)
      AND EXTRACT(YEAR FROM hire_date) NOT IN (1994, 1995)
    ORDER BY hire_date DESC;
       
-- Q2. Show modified salaries for Vice Presidents and Managers who make outside
-- the $6,000 to $11,000 range.
SELECT 'Emp#' || employee_id || ' named ' || first_name || ' ' || last_name
    || ' who is ' || job_id || ' will have a new salary of ' ||
    TO_CHAR(CASE WHEN job_id LIKE '%_VP' THEN salary * 1.3 ELSE salary * 1.2 END,
    'fmL999990') AS "Employees with Increased Pay"
    FROM employees
    WHERE salary NOT BETWEEN 6000 AND 11000
      AND (job_id LIKE '%_VP' OR job_id LIKE '%_MAN' OR job_id LIKE '%_MGR')
    ORDER BY salary DESC;
    
-- Q3. Show salary information for non-commissioned employees with the exception of those
-- employees who work in the Sales department who earn above a certain threshold.
SELECT last_name, salary, job_id, NVL(CAST(manager_id AS CHAR(10)), 'NONE') AS "Manager#",
    TO_CHAR((salary * (1 + NVL(commission_pct, 0)) + 1000) * 12, 'fmL999G990D90')
    AS "Total Income"
--    salary * (1 + NVL(commission_pct, 0)) + 1000, commission_pct
    FROM employees
    WHERE commission_pct IS NULL OR (department_id = 80 AND
        salary * (1 + NVL(commission_pct, 0)) + 1000 > 15000);
        
-- Q4. Show the lowest pay for each department or job but exclude
-- representative jobs and employees who work in IT and Sales.
-- 60=IT, 80=Sales
SELECT department_id, job_id, MIN(salary) AS "Lowest Dept/Job Pay"
    FROM employees
    WHERE job_id NOT LIKE '%_REP' AND department_id NOT IN (60, 80)
    GROUP BY department_id, job_id
    HAVING MIN(salary) BETWEEN 6000 AND 18000
    ORDER BY department_id, job_id;
    
-- Q5. Find all employees who earn more than all the lowest paid employees
-- by departments outside of the US.
SELECT last_name, salary, job_id
    FROM employees
    WHERE salary > ANY(
        SELECT MIN(salary)
            FROM employees e
              INNER JOIN departments d
                ON e.department_id = d.department_id
              INNER JOIN locations l
                  ON d.location_id = l.location_id
            WHERE UPPER(l.country_id) <> 'US'
            GROUP BY e.department_id
    );
      
-- Q6. Find employees in IT and Marketing that earn more than the lowest
-- paid employee in Accounting.
SELECT last_name, salary, job_id, department_id
    FROM employees
    WHERE department_id IN (
      SELECT department_id
          FROM departments
          WHERE UPPER(department_name) IN ('IT', 'MARKETING')
      )
      AND salary > (
        SELECT MIN(salary)
            FROM employees
            WHERE department_id = (
                SELECT department_id FROM departments
                    WHERE UPPER(department_name) = 'ACCOUNTING'
                )
        );
    
-- Q7. Find employees who earn less than the best paid unionized employees
-- (excludes managers, vice presidents, and presidents) and who work in
-- either SALES or MARKETING.
SELECT SUBSTR(first_name || ' ' || last_name, 1, 25) AS "Employee", job_id,
    LPAD(TO_CHAR(salary, 'fmL999G990'), 12, '=') AS "Salary", department_id
    FROM employees
    WHERE department_id IN (
      SELECT department_id
          FROM departments
          WHERE UPPER(department_name) IN ('SALES', 'MARKETING')
      )
    AND salary < (
      SELECT MAX(salary) FROM employees
          WHERE NOT (UPPER(job_id) LIKE '%_PRES' OR UPPER(job_id) LIKE '%_VP'
            OR UPPER(job_id) LIKE '%_MAN' OR UPPER(job_id) LIKE '%_MGR')
      )
    ORDER BY "Employee" ASC;
         
-- Q8. Find the number of jobs per department.
-- Include employees who have no department and cities without departments.
SELECT e.department_id, SUBSTR(NVL(city, 'Not Assigned Yet'), 1, 25) AS "City",
    COUNT(DISTINCT e.job_id) AS "# of Jobs"
    FROM employees e
      LEFT OUTER JOIN departments d
        ON e.department_id = d.department_id
      FULL OUTER JOIN locations l
        ON d.location_id = l.location_id
    GROUP BY e.department_id, city
    HAVING COUNT(DISTINCT e.job_id) > 0;