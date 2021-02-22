--create a new database called PRD, which signifies that the database contains production data. We will also two  schemas called SRC_DATA, INTEGRATED_DATA & REPORTING_DATA.
CREATE DATABASE PRD;
CREATE SCHEMA SRC_DATA;
CREATE SCHEMA INTEGRATED_DATA;
CREATE SCHEMA REPORTING_DATA;

--create a series of tables in these databases. 
USE SCHEMA SRC_DATA;
CREATE TABLE CUSTOMER AS 
SELECT * FROM SNOWFLAKE_SAMPLE_DATA.TPCH_SF1.CUSTOMER;

USE SCHEMA SRC_DATA;
CREATE TABLE LINEITEM AS 
SELECT * FROM SNOWFLAKE_SAMPLE_DATA.TPCH_SF1.LINEITEM;

USE SCHEMA INTEGRATED_DATA;
CREATE TABLE ORDERS AS 
SELECT * FROM SNOWFLAKE_SAMPLE_DATA.TPCH_SF1.ORDERS;


--create a reporting view to demonstrate that views also get cloned.
USE SCHEMA REPORTING_DATA;
CREATE VIEW REVENUE_REPORT AS 
SELECT
L_RETURNFLAG,
L_LINESTATUS,
SUM(L_QUANTITY) AS SUM_QTY,
SUM(L_EXTENDEDPRICE) AS SUM_BASE_PRICE,
SUM(L_EXTENDEDPRICE * (1-L_DISCOUNT)) AS SUM_DISC_PRICE,
SUM(L_EXTENDEDPRICE * (1-L_DISCOUNT) * (1+L_TAX)) AS SUM_CHARGE,
AVG(L_QUANTITY) AS AVG_QTY,
AVG(L_EXTENDEDPRICE) AS AVG_PRICE,
AVG(L_DISCOUNT) AS AVG_DISC,
COUNT(*) AS COUNT_ORDER
FROM PRD.SRC_DATA.LINEITEM
WHERE L_SHIPDATE <= DATEADD(DAY, -90, TO_DATE('1998-12-01'))
GROUP BY L_RETURNFLAG,L_LINESTATUS;

--create a brand-new development environment for this PRD database, and we will create it with data. 
CREATE DATABASE DEV_DB_1 CLONE PRD;
 
--validate that the new environment has all the required objects. To do so, expand the database tree in the left side of the Snowflake Web UI, you should see the following structure of database, schemas, tables & views.
 
--validate that there is actual data in the cloned tables.
SELECT COUNT(*) FROM DEV_DB_1.SRC_DATA.CUSTOMER;

--validate that there is actual data in the cloned views.
SELECT COUNT(*) FROM DEV_DB_1.REPORTING_DATA.REVENUE_REPORT;
 
--create a testing environment from the production environment.
CREATE DATABASE TEST_1 CLONE PRD;

--create a new development environment from the existing development environment. To do so run the following SQL:
CREATE DATABASE DEV_DB_2 CLONE DEV_DB_1;