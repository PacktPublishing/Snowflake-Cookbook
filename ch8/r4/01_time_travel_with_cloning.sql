--start by creating a new database called PRODUCTION_DB, which signifies that the database contains production data. We will also create a schema called SRC_DATA, which signifies that it contains raw data from the source systems.
CREATE DATABASE PRODUCTION_DB;
CREATE SCHEMA SRC_DATA;

--create a test table call INVENTORY in this schema. We will be using sample data provided by Snowflake to populate this table.
CREATE TABLE INVENTORY AS 
SELECT * FROM SNOWFLAKE_SAMPLE_DATA.TPCDS_SF10TCL.INVENTORY
LIMIT 100000;

--create another test table called ITEM in this schema. Again, we will be using sample data provided by Snowflake to populate this table.
CREATE TABLE ITEM AS 
SELECT * FROM SNOWFLAKE_SAMPLE_DATA.TPCDS_SF10TCL.ITEM
LIMIT 100000;

--create another schema by the name of ACCESS_LAYER.
USE DATABASE PRODUCTION_DB;
CREATE SCHEMA ACCESS_LAYER;

--create a test table call STORE_SALES in this schema. We will be using sample data provided by Snowflake to populate this table.
CREATE TABLE STORE_SALES AS 
SELECT * FROM SNOWFLAKE_SAMPLE_DATA.TPCDS_SF10TCL.STORE_SALES
LIMIT 100000;

--make note of the current time as we would need that information to clone our production database as it existed at a specific time.
SELECT CURRENT_TIMESTAMP;
 
--check the count of rows in each table so that when we clone the database in conjunction with time travel, we can demonstrate the database is cloned at a time before additional data was added to the table.
SELECT COUNT(*) FROM PRODUCTION_DB.SRC_DATA.INVENTORY;
SELECT COUNT(*) FROM PRODUCTION_DB.SRC_DATA.ITEM;
SELECT COUNT(*) FROM PRODUCTION_DB.ACCESS_LAYER.STORE_SALES;

--insert more data into all the tables in our PRODUCTION_DB database, simulating how a normal ETL run may execute every day. 
INSERT INTO PRODUCTION_DB.SRC_DATA.INVENTORY
SELECT * FROM SNOWFLAKE_SAMPLE_DATA.TPCDS_SF10TCL.INVENTORY
LIMIT 20000;

INSERT INTO PRODUCTION_DB.SRC_DATA.ITEM
SELECT * FROM SNOWFLAKE_SAMPLE_DATA.TPCDS_SF10TCL.ITEM
LIMIT 20000;

INSERT INTO PRODUCTION_DB.ACCESS_LAYER.STORE_SALES
SELECT * FROM SNOWFLAKE_SAMPLE_DATA.TPCDS_SF10TCL.STORE_SALES
LIMIT 20000;

--clone the PRODUCTION_DB database into DEV_1 database, and while doing so also go back in time when the table only had the initial set of rows.
CREATE DATABASE DEV_1 CLONE PRODUCTION_DB AT(TIMESTAMP => '<replace with the timestamp from step#7>'::timestamp_tz);

--the DEV_1 database is cloned from PRODUCTION_DB database however it should contain only 100,000 rows that were originally inserted in the tables. Validate that by running count queries on the tables in DEV_1 database.
SELECT COUNT(*) FROM DEV_1.SRC_DATA.INVENTORY;
SELECT COUNT(*) FROM DEV_1.SRC_DATA.ITEM;
SELECT COUNT(*) FROM DEV_1.ACCESS_LAYER.STORE_SALES;
