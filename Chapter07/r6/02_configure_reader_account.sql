 
--use a browser to navigate to the Reader Account

--create a virtual warehouse for the reader account since the reader account does not have a virtual warehouse by default.
USE ROLE ACCOUNTADMIN;
CREATE WAREHOUSE SP_VW WITH 
WAREHOUSE_SIZE = 'SMALL' WAREHOUSE_TYPE = 'STANDARD' 
AUTO_SUSPEND = 300 AUTO_RESUME = TRUE 
INITIALLY_SUSPENDED = TRUE;
