-- create a new user which will act as database administrator for the development environment.
USE ROLE SECURITYADMIN;

CREATE USER dev_dba_user1
PASSWORD = 'password123' 
DEFAULT_ROLE = DEV_DBA;
 
--create a role for the development DBA and grant it to the development user.
CREATE ROLE DEV_DBA;
GRANT ROLE DEV_DBA TO USER dev_dba_user1;

 
--switch to the SYSADMIN role and create the development database.
USE ROLE SYSADMIN;
CREATE DATABASE DEV;
 
--grant full access to the DEV_DBA role.
GRANT ALL ON DATABASE DEV TO ROLE DEV_DBA;
 
--create the production database, roles & user using the same approach.
USE ROLE SECURITYADMIN;

CREATE USER prod_dba_user1
PASSWORD = 'password123' 
DEFAULT_ROLE = PROD_DBA;
 
--create a role for the production DBA and grant it to the production user.
CREATE ROLE PROD_DBA;
GRANT ROLE PROD_DBA TO USER prod_dba_user1;
 
--switch to the SYSADMIN role and create the production database.
USE ROLE SYSADMIN;
CREATE DATABASE PROD;
 
--grant full access to the PROD_DBA role.
GRANT ALL ON DATABASE PROD TO ROLE PROD_DBA;
