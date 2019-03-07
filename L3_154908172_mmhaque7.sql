-- ***********************
-- Name: Mehedi Haque
-- ID: 154908172
-- Date: September 24, 2018
-- Purpose: Lab 3 DBS301
-- ***********************
--Q1- Displayed the query for tomorows date using the format given.
 -- Convert to string with the default format

Select 
    TO_CHAR(SYSDATE +1, 'fmMonth DD"th of year" YYYY') AS "Tomorrow"
    FROM Dual;

--Q2--displayed first name, last name, salary and salary increased by 5% from employees from 
--departments 20 ,50 and 60. Also added a new column that subtracts the old salary from the 
--new salary and multiplied by 12.

SELECT 
        first_name AS "First Name",
        last_name AS "Last Name",
        TO_CHAR(salary, '$999,999.99') AS "Salary",
        TO_CHAR(ROUND(salary * 1.05),'$999,999.99' ) AS "Good Salary",
        TO_CHAR(ROUND(((salary *1.05) - salary)* 12),'$999,999.99') AS "Annual Pay Increase"
    FROM employees
    WHERE department_id in (20, 50, 60);

--Q3--created a query that displays the employee’s Full Name and Job Title 
--in the following format:DAVIES, CURTIS is ST_CLERK 

SELECT 
        UPPER(last_name)||','||UPPER(first_name)||' is '||
        job_id AS "Person and Job"
    FROM EMPLOYEES
    WHERE UPPER(last_name) LIKE '%S' AND 
    UPPER(first_name) LIKE 'C%' OR UPPER(first_name) LIKE 'K%'
    ORDER BY last_name; 

--Q4--For each employee hired before 1992, display the employee’s 
--last name, hiredate and calculate the number of YEARS between TODAY 
--and the date the employee was hired

SELECT 
        last_name,
        hire_date,
        ROUND(MONTHS_BETWEEN(SYSDATE, hire_date)/12) AS "Years Worked"
    FROM employees
    WHERE TO_NUMBER(TO_CHAR(hire_date,'YYYY'))  < 1992
    ORDER BY "Years Worked" DESC;
--Q5--5.	Create a query that displays the city names, country codes 
--and state province names, but only for those cities that starts with 
--S and has at least 8 characters in their name. If city does not have 
--a province name assigned, then put Unknown Province

SELECT 
        city,
        country_id,
        NVL(state_province,'Unknown Province') AS "Province"
    FROM locations
    WHERE UPPER(city) LIKE 'S%' AND
    LENGTH(city)>= 8;

--Q6--Display each employee’s last name, hire date, and salary 
--review date, which is the first Thursday after a year of service, 
--but only for those hired after 1997.  
SELECT
    last_name,
    hire_date,
    TO_CHAR(NEXT_DAY(ADD_MONTHS(hire_date,12),'Thursday'),
    'fmDay, Month "the" fmDdspth "of year "fmyyyy') AS "REVIEW DAY"
    FROM employees
    WHERE TO_NUMBER(TO_CHAR(hire_date,'YYYY')) > 1997
    ORDER BY (NEXT_DAY(TO_DATE(ADD_MONTHS(hire_date, '12')), 'THURSDAY'));

---------END OF FILE--------------


















