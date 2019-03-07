-- ***********************
-- Name: Mehedi Haque
-- ID: 154908172
-- Date: November 19 2018
-- Purpose: Lab 9 DBS301
-- ***********************
--1.	Create table SALESREP and load it with data from table EMPLOYEES table. Use only the equivalent columns 
--from EMPLOYEE as shown below and only for people in department 80.
CREATE TABLE salesrep(
    repid NUMBER(6),
    fname VARCHAR2(20),
    lname VARCHAR2(25),
    phone# VARCHAR2(20),
    salary NUMBER(8,2),
    commission NUMBER(2,2),
CONSTRAINT salesrep_repid_pk PRIMARY KEY (repid)
);
INSERT INTO salesrep
    SELECT employee_id, first_name, last_name, phone_number, salary, commission_pct 
        FROM employees
        WHERE department_id = 80;
        
--2.	Create CUST table.
CREATE TABLE cust (
cust# NUMBER(6),
custname VARCHAR2(30),
city VARCHAR2(20),
rating CHAR(1),
comments VARCHAR2(200),
salesrep# NUMBER(7),
CONSTRAINT cust_cust#_pk PRIMARY KEY (Cust#),
CONSTRAINT cust_custname_city_uk UNIQUE (CustName, City),
CONSTRAINT cust_rating_ck CHECK (Rating IN ('A', 'B', 'C', 'D')),
CONSTRAINT cust_salesrep#_fk FOREIGN KEY (SalesRep#)
    REFERENCES salesrep (repid));
    
INSERT INTO cust (cust#, custname, city, rating, salesrep#) VALUES(501, 'ABC LTD.', 'Montreal', 'C', 149);
INSERT INTO cust (cust#, custname, city, rating, salesrep#) VALUES(502, 'Black Giant', 'Ottawa', 'B', 174);
INSERT INTO cust (cust#, custname, city, rating, salesrep#) VALUES(503, 'Mother Goose', 'London', 'B', 174);
INSERT INTO cust (cust#, custname, city, rating, salesrep#) VALUES(701, 'BLUE SKY LTD', 'Vancouver', 'B', 176);
INSERT INTO cust (cust#, custname, city, rating, salesrep#) VALUES(702, 'MIKE and SAM LTD', 'Kingston', 'A', 174);
INSERT INTO cust (cust#, custname, city, rating, salesrep#) VALUES(703, 'RED PLANET', 'Missisauga', 'C', 174);
INSERT INTO cust (cust#, custname, city, rating, salesrep#) VALUES(717, 'BLUE SKY LTD', 'Regina', 'D', 176);

--3.	Create table GOODCUST by using following columns but only if their rating is A or B
CREATE TABLE goodcust (
custid NUMBER(6),
"name" VARCHAR2(30),
"location" VARCHAR2(20),
repid NUMBER(7));

INSERT INTO goodcust
    SELECT cust#, custname, city, salesrep#
        FROM cust
        WHERE UPPER(rating) IN ('A', 'B');
        
--Now add new column to table SALESREP called JobCode that will be of variable character type with max length of 12
ALTER TABLE salesrep
    ADD JobCode VARCHAR2(12);
    
--5.	Declare column Salary in table SALESREP as mandatory one and Column Location in table GOODCUST as optional one.
ALTER TABLE salesrep
    MODIFY (salary NUMBER(8, 2) NOT NULL,
            lname VARCHAR2(25) NOT NULL,
            repid NUMBER(6) NOT NULL,
            fname VARCHAR2(37));
--6.	Now get rid of the column JobCode in table SALESREP in a way that will not affect daily performance. 
ALTER TABLE salesrep
    DROP COLUMN jobcode;
    
--7.	Declare PK constraints in both new tables ? RepId and CustId
ALTER TABLE salesrep
ADD CONSTRAINT salesrep_repid_pk PRIMARY KEY (repid);
ALTER TABLE goodcust
ADD CONSTRAINT goodcust_custid_pk PRIMARY KEY (custid);

--8.	Declare UK constraints in both new tables ? Phone# and Name
ALTER TABLE salesrep
    ADD CONSTRAINT salesrep_phone#_uk UNIQUE (phone#);
ALTER TABLE goodcust
    ADD CONSTRAINT goodcust_name_uk UNIQUE ("name");
--9.	Restrict amount of Salary column to be in the range [6000, 12000] and Commission to be not more than 50%.
ALTER TABLE salesrep
    ADD CONSTRAINT salesrep_salary_ck CHECK(salary >= 6000 AND salary <= 12000)
    ADD CONSTRAINT salesrep_commission_ck CHECK(commission <= .50);
--10.	Ensure that only valid RepId numbers from table SALESREP may be entered in the table GOODCUST. 
--Why this statement has failed?
--INSERT INTO goodcust (repid)
--   SELECT repid FROM salesrep;
--it falied because custid was empty.

--11.	Firstly write down the values for RepId column in table GOODCUST and then make all these values blank. 
--Now redo the question 10. Was it successful? 
--INSERT INTO goodcust (repid)
--   SELECT repid FROM salesrep;
--Yes it was successful.

--12.	Disable this FK constraint now and enter old values for RepId in table GOODCUST and save them. 
--Then try to enable your FK constraint. What happened? 
--Fk was enabled agian.

--13.	Get rid of this FK constraint. Then modify your CK constraint from question 9 to allow Salary amounts from 5000 to 15000
ALTER TABLE salesrep
    DROP CONSTRAINT salesrep_salary_ck;
ALTER TABLE salesrep
    ADD CONSTRAINT salesrep_salary_ck CHECK(salary >= 5000 AND salary <= 15000);
--14.	Describe both new tables SALESREP and GOODCUST and then show all constraints for these two 
--tables by running the following query:

SELECT  constraint_name, constraint_type, search_condition, table_name
    FROM user_constraints
    WHERE UPPER(table_name) IN ('SALESREP', 'GOODCUST')
    ORDER BY 4,2;
            