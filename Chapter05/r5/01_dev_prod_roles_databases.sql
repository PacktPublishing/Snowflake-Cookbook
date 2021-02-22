-- create a new user which will act as database administrator for the development environment.
USE ROLE SECURITYADMIN;

CREATE USER dev_dba_1
PASSWORD = 'password123' 
DEFAULT_ROLE = DEV_DBA_ROLE
MUST_CHANGE_PASSWORD = TRUE;
 
--create a role for the development DBA and grant it to the development user.
CREATE ROLE DEV_DBA_ROLE;
GRANT ROLE DEV_DBA_ROLE TO USER dev_dba_1;

 
--switch to the SYSADMIN role and create the development database.
USE ROLE SYSADMIN;
CREATE DATABASE DEV_DB;
 
--grant full access to the DEV_DBA_ROLE role.
GRANT ALL ON DATABASE DEV_DB TO ROLE DEV_DBA_ROLE;
 
--create the production database, roles & user using the same approach.
USE ROLE SECURITYADMIN;

CREATE USER prod_dba_1
PASSWORD = 'password123' 
DEFAULT_ROLE = PROD_DBA_ROLE
MUST_CHANGE_PASSWORD = TRUE;
 
--create a role for the production DBA and grant it to the production user.
CREATE ROLE PROD_DBA_ROLE;
GRANT ROLE PROD_DBA_ROLE TO USER prod_dba_1;
 
--switch to the SYSADMIN role and create the production database.
USE ROLE SYSADMIN;
CREATE DATABASE PROD_DB;
 
--grant full access to the PROD_DBA_ROLE role.
GRANT ALL ON DATABASE PROD_DB TO ROLE PROD_DBA_ROLE;
