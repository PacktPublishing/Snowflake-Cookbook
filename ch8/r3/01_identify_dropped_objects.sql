--start by creating a new database, followed by creation of a schema. 
CREATE DATABASE C8_R3;
CREATE SCHEMA SCHEMA1;

 
--create a test table called CUSTOMER in this schema. We will be using sample data provided by Snowflake to populate this table.
CREATE TABLE CUSTOMER AS 
SELECT * FROM SNOWFLAKE_SAMPLE_DATA.TPCDS_SF10TCL.CUSTOMER
LIMIT 100000;

--create another test table call CUSTOMER_ADDRESS in this schema. Again, we will be using sample data provided by Snowflake to populate this table. 
CREATE TABLE CUSTOMER_ADDRESS AS 
SELECT * FROM SNOWFLAKE_SAMPLE_DATA.TPCDS_SF10TCL.CUSTOMER_ADDRESS
LIMIT 100000;

--create another schema by the name of SCHEMA2.
USE DATABASE C8_R3;
CREATE SCHEMA SCHEMA2;
 
--create a test table call INVENTORY in this schema. We will be using sample data provided by Snowflake to populate this table.
CREATE TABLE INVENTORY AS 
SELECT * FROM SNOWFLAKE_SAMPLE_DATA.TPCDS_SF10TCL.INVENTORY
LIMIT 100000;

--drop the customer table from the CUSTOMER schema.
USE SCHEMA SCHEMA1;
DROP TABLE CUSTOMER;
 
--programmatically find out the tables that may have been dropped
--Tables which have been dropped will have a non-NULL date value in the TABLE_DROPPED column.
USE ROLE ACCOUNTADMIN;
SELECT TABLE_CATALOG, TABLE_SCHEMA,TABLE_NAME,
ID,CLONE_GROUP_ID, TABLE_CREATED, TABLE_DROPPED 
FROM INFORMATION_SCHEMA.TABLE_STORAGE_METRICS WHERE TABLE_CATALOG = 'C8_R3';

--Let us now restore the dropped table.
USE SCHEMA SCHEMA1;
UNDROP TABLE CUSTOMER;
 
--Validate that the table is indeed available now
SELECT COUNT(*) FROM CUSTOMER;

--drop the whole SCHEMA1 schema.
DROP SCHEMA SCHEMA1;
 
--Restore the schema.
UNDROP SCHEMA SCHEMA1;