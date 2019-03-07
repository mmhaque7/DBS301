-- ***********************
-- Name: Mehedi Haque
-- ID: 154908172
-- Date: November 25 2018
-- Purpose: Lab 10 DBS301
-- ***********************

--1.	Create table CITIES from table LOCATIONS, but only for location numbers less than 2000 
CREATE TABLE CITIES AS(
    SELECT location_id, street_address, postal_code, city, state_province, country_id
    FROM locations
    WHERE location_id < 2000);

--2.	Create table TOWNS from table LOCATIONS, but only for location numbers less than 1500 
CREATE TABLE TOWNS AS (
    SELECT location_id, street_address, postal_code, city, state_province, country_id
    FROM locations
    WHERE location_id < 1500);
--3.    Now you will empty your RECYCLE BIN with one powerful command. Then remove your table TOWNS, so that will 
--remain in the recycle bin. Check that it is really there and what time was removed. 
PURGE RECYCLEBIN;-->this removes everything from the recycle bin.
DROP TABLE TOWNS;-->removed table TOWNS.
SELECT * FROM RECYCLEBIN;-->check if TOWNS is in the recyclebin.

--4.    Restore your table TOWNS from recycle bin and describe it. Check what is in your recycle bin now.
FLASHBACK TABLE TOWNS TO BEFORE DROP;
SELECT * FROM RECYCLEBIN;

--5.    Now remove table TOWNS so that does NOT remain in the recycle bin. Check that is really NOT there and then 
--try to restore it. Explain what happened?
DROP TABLE TOWNS; 
PURGE RECYCLEBIN; 
FlASHBACK TABLE TOWNS TO BEFORE DROP; 
---ORA-38305: object not in RECYCLE BIN. basically after droping the TOWNS TABLE we purged the recyclebin which in turn deleted
--everything in the recyclebin therfore when using flashback the error occured casue the table in recyclebin was deleted and could
--not be returned.

--6.    Create simple view called CAN_CITY_VU, based on table CITIES so that will contain only columns Street_Address, 
--Postal_Code, City and State_Province for locations only in CANADA. Then display all data from this view.
CREATE VIEW CAN_CITY_VU AS (
    SELECT Street_Address, Postal_Code, City, State_Province
    FROM locations
    WHERE UPPER(country_id) = 'CA');
--7.    Modify your simple view so that will have following aliases instead of original column names: Str_Adr, P_Code, City and 
--Prov and also will include cities from ITALY as well. Then display all data from this view.
CREATE OR REPLACE VIEW CAN_CITY_VU AS(
    SELECT Street_Address AS "Str_Adr", Postal_Code AS "P_Code", City, State_Province AS "Prov"
    FROM locations);

--8.    Create complex view called CITY_DNAME_VU, based on tables LOCATIONS and DEPARTMENTS, so that will contain only columns 
--Department_Name, City and State_Province for locations in ITALY or CANADA. Include situations even when city does NOT have 
--department established yet. Then display all data from this view.
CREATE VIEW CITY_DNAME_VU AS (
    SELECT Department_Name, City, State_Province
    FROM locations LEFT JOIN departments USING(location_id)
    WHERE upper(country_id) IN ('IT', 'CA'));

--9.    Modify your complex view so that will have following aliases instead of original column names: DName, City and 
--Prov and also will include all cities outside United States 
CREATE OR REPLACE VIEW CITY_DNAME_VU AS (
    SELECT Department_Name AS "DName", City, State_Province AS "Prov"
    FROM locations LEFT JOIN departments USING(location_id)
    WHERE UPPER(country_id) IN ('IT', 'CA') OR UPPER(country_id) != ('US'));

--10    Check in the Data Dictionary what Views (their names and definitions) are created so far in your account.
SELECT view_name FROM user_views;
DROP VIEW CITY_DNAME_VU;
SELECT view_name FROM user_views;
--the city_dname_vu does not exists.
    