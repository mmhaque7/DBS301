-- ************************
-- DBS301 Midterm Test # 2
-- Fall 2018
-- Clint MacDonald
-- Solutions
-- ************************
--
-- This is a closed book test, no aids are permitted.
-- Top marks can only be achieved if all code conforms 
-- with the style guide used in class.  
--
-- Ensure consideration for case sensitivity, internationalization,
-- and time zones in all answer.
--
-- There are 6 questions, for a total of 35 marks.
-- ***********************************************************************
-- Q1 (5 marks)
-- a) Create a new temporary table, called t2tmpUSdepartments, that shows names of the departments that have 
-- offices in the US.  Include the department id, department name, city and state.
    -- Complete this task using only a single SQL statement.
    -- Include all departments and all locations in the data. 
    -- your answer should have 7 results
DROP TABLE t2tmpUSdepartments;    
-- Q1 SOLUTION
CREATE TABLE t2tmpUSdepartments AS (
    SELECT department_id, department_name, city, state_province
        FROM departments FULL JOIN locations USING (location_id)
        WHERE UPPER(country_id) = 'US' );
SELECT * FROM t2tmpUSdepartments;
--Q2 (5 marks)
-- a) List all cities in the database. (3 marks)
    -- Show the Canadian cities first, 
    -- followed by US cities,
    -- followed by all other cities.  
    -- Do not list any city more than once.
    
-- SOLUTION
SELECT DISTINCT city FROM locations WHERE UPPER(country_id) = 'CA'
UNION ALL
SELECT DISTINCT city FROM locations WHERE UPPER(country_id) = 'US'
UNION ALL
SELECT DISTINCT city FROM locations WHERE UPPER(country_id) NOT IN ('CA', 'US');

-- b) Repeat the same query but now (2 marks)
    -- Sort the Canadian cities alphabetically, 
    -- the US cities alphabetically and the rest of the cities 
    -- alphabetically without changing the order in which the 
    -- countries are shown. 

SELECT * FROM (
    SELECT DISTINCT city FROM locations 
    WHERE UPPER(country_id) = 'CA' ORDER BY city)
UNION ALL
SELECT * FROM (
    SELECT DISTINCT city FROM locations 
    WHERE UPPER(country_id) = 'US' ORDER BY city)
UNION ALL
SELECT * FROM (
    SELECT DISTINCT city FROM locations 
    WHERE UPPER(country_id) NOT IN ('CA', 'US') ORDER BY city);
    
--Q3 a) There currently is not any referential integrity on the country_id 
--      field in the locations table.  Write a statement that enforces this rule. 
--      (3 marks)

ALTER TABLE locations 
    ADD CONSTRAINT location_country_fk FOREIGN KEY (country_id) 
        REFERENCES countries(country_id);

--   b) In the countries table, add a rule to the region_id column that ensures that 
--      the region is one that exists (1, 2, 3, 4, 5) only.
--      (2 marks)

ALTER TABLE countries
    ADD CONSTRAINT countries_region_id_chk CHECK (region_id IN (1, 2, 3, 4, 5));
    
--Q4
-- The company is expanding, adding 2 new offices to the company.  
-- Add the following offices locations to the database 
-- (do not worry about departments at this time). (5 marks)
-- STREET:          2000 Simcoe St. N.      ul. Kommunizma d. 24, kv. 15
-- CITY:            Oshawa,                 Novomosskovsk
-- STATE/COUNTRY:   ON, Canada (CA)         Tula Oblast, Russia (RU)
-- POSTAL CODE:     L1G 0C5                 123456

INSERT INTO countries VALUES('RU', 'Russia', 1);
INSERT INTO locations VALUES(98, '2000 Simcoe St. N', 'L1G0C5', 'Oshawa', 'ON', 'CA');
INSERT INTO locations VALUES(99, 'ul. Kommunizma d. 24, kv. 15', '123456', 'Novomosskovsk', 'Tula Oblast', 'RU');

--Q5 (8 marks)
-- Execute the following creation script
DROP TABLE t2BankAccounts;
CREATE TABLE t2BankAccounts (
    account_number INT PRIMARY KEY,
    client_id INT NOT NULL,
    account_type varchar2(1) CHECK (account_type IN ('S', 'C')) NOT NULL,
    account_balance decimal(10,2) DEFAULT(0.0) NOT NULL CHECK (account_balance >= 0.0));
INSERT INTO t2BankAccounts VALUES (1234, 12, 'S', 4567.89);
INSERT INTO t2BankAccounts VALUES (4321, 12, 'C', 124.12);

-- Use transactional SQL to perform the following tasks.
    -- a) Write a statement to ensure that the above script is performed 
    --      and the insertions are permanent. (2 marks)
    COMMIT;
    -- b) Client 12 wants to move $400 from the Chequing (C) account 
    --    to the Savings (S) account.  Write the appropriate statements 
    --    required to do this.
    --          - if you were to perform the exact statement twice successfully, 
    --            the balance would be $800 different) (3 marks)
    -- c) Add the ability to undo part of the transaction by adding a statement between 
    --    each part of the transaction (call these "withdrawal" and "deposit") (2 marks)
    -- d) it is obvious that the withdrawal can not happen as requested, 
    --    in words, describe what should happen at this point. Add the appropriate statement.
    --    (3 marks)
    UPDATE t2BankAccounts 
        SET account_balance = account_balance - 400
        WHERE account_number = 4321;
    SAVEPOINT withdrawal;
    UPDATE t2BankAccounts
        SET account_balance = account_balance + 400 
        WHERE account_number = 1234;
    SAVEPOINT deposit;
    ROLLBACK;
    
    