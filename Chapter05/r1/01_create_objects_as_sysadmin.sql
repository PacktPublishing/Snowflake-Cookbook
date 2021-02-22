--create a database DEV.
USE ROLE SYSADMIN;
CREATE DATABASE DEV;
 
-- create a table for testing purposes
USE DATABASE DEV;
CREATE TABLE CUSTOMER
( ID STRING,
NAME STRING);

--change your role to SECURITY ADMIN so that you have the required privileges to create a new user & a new role. 
USE ROLE SECURITYADMIN;

--create a new user which we will use to demonstrate the role privileges. 
CREATE USER dev_dba_user1 PASSWORD='password123' MUST_CHANGE_PASSWORD = TRUE;