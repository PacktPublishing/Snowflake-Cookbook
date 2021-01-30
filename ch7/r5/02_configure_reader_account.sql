 
--use a browser to navigate to the Reader Account

--create a virtual warehouse for the reader account since the reader account does not have a virtual warehouse by default.
USE ROLE ACCOUNTADMIN;
CREATE WAREHOUSE SP_VW WITH 
WAREHOUSE_SIZE = 'SMALL' WAREHOUSE_TYPE = 'STANDARD' 
AUTO_SUSPEND = 300 AUTO_RESUME = TRUE 
INITIALLY_SUSPENDED = TRUE;

--grant the USAGE privileges to the PUBLIC role so that any user in the reader account can use the virtual warehouse. 
GRANT USAGE ON WAREHOUSE SP_VW TO ROLE PUBLIC;

--grant ALL privileges on the virtual warehouse to the SYSADMIN role so that the SYSADMIN role can manage the virtual warehouse.
GRANT ALL ON WAREHOUSE SP_VW TO ROLE SYSADMIN;