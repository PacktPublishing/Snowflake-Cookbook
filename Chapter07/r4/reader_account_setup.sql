-- create a new administrator for the reader account. 
USE ROLE SECURITYADMIN;
CREATE USER SP_SYSADMIN PASSWORD='abc123' DEFAULT_ROLE = SYSADMIN MUST_CHANGE_PASSWORD = TRUE;


-- grant the administrator sys admin as well as security administrator roles
GRANT ROLE SYSADMIN TO USER SP_SYSADMIN;
GRANT ROLE SECURITYADMIN TO USER SP_SYSADMIN;


-- create a new virtual warehouse for the reader account.
USE ROLE ACCOUNTADMIN;
CREATE WAREHOUSE SP_VW WITH 
WAREHOUSE_SIZE = 'SMALL' SCALING_POLICY = 'STANDARD' 
AUTO_SUSPEND = 300 AUTO_RESUME = TRUE 
INITIALLY_SUSPENDED = TRUE;


-- grant privileges to everyone to use the virtual warehouse
GRANT USAGE ON WAREHOUSE SP_VW TO ROLE PUBLIC;

-- grant full privilege to the SYSADMIN role
GRANT ALL ON WAREHOUSE SP_VW TO ROLE SYSADMIN;
