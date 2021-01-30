--login back to the reader account 

--create a new database from the share object.
USE ROLE ACCOUNTADMIN;
CREATE DATABASE SALES FROM SHARE <provider_account_name_here>.share_sales_data;

--select from the view in the database created from the share. 
SELECT * FROM SALES.PUBLIC.STORE_SALES_AGG;