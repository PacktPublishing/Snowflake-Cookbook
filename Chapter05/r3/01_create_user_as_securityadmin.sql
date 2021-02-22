--Create a new database which will use to demonstrate the privilege management.
USE ROLE SYSADMIN;
CREATE DATABASE test_database;
 
--Create a new user which we will call user_operations1.
USE ROLE SECURITYADMIN;
CREATE USER user_operations1 PASSWORD='password123' MUST_CHANGE_PASSWORD = TRUE;
 
--grant the USERADMIN role to this user and will make it their default role.
USE ROLE SECURITYADMIN;
GRANT ROLE USERADMIN TO USER user_operations1;
ALTER USER user_operations1 SET DEFAULT_ROLE = USERADMIN;