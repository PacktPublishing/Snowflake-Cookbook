-- login back to the provider account before running these steps

--create a sample table in the provider account. To do so, run the following SQL: 
CREATE DATABASE CUSTOMER_DATA;
CREATE TABLE STORE_SALES AS 
SELECT * FROM SNOWFLAKE_SAMPLE_DATA.TPCDS_SF10TCL.STORE_SALES
LIMIT 1000;

--create a secure view on top of the STORE_SALES table. 
USE DATABASE CUSTOMER_DATA;
CREATE OR REPLACE SECURE VIEW STORE_SALES_AGG
AS
SELECT SS_SOLD_DATE_SK,SUM(SS_NET_PROFIT) AS SS_NET_PROFIT
FROM CUSTOMER_DATA.PUBLIC.STORE_SALES
GROUP BY 1;

--create a share object.
USE ROLE ACCOUNTADMIN;
CREATE SHARE share_sales_data;

--perform the necessary grants to include the objects in the share. 
GRANT USAGE ON DATABASE CUSTOMER_DATA TO SHARE share_sales_data;
GRANT USAGE ON SCHEMA CUSTOMER_DATA.public TO SHARE share_sales_data;
GRANT SELECT ON VIEW CUSTOMER_DATA.PUBLIC.STORE_SALES_AGG TO SHARE share_sales_data;

--share the data with the reader account. 
ALTER SHARE share_sales_data ADD ACCOUNT=<reader_account_name_here>;