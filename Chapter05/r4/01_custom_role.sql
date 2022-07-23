-- create the database which will hold the sensitive data. In this database we will also create a table that contains salary information.
USE ROLE SYSADMIN;
CREATE DATABASE sensitive_data;
CREATE TABLE SALARY
(
  EMP_ID INTEGER,
  SALARY NUMBER
);
 
--create a role which will have access to this data.
USE ROLE SECURITYADMIN;
CREATE ROLE HR_ROLE;
 
--grant the necessary privileges to this role. We will transfer the ownership of the database & the table that we previously created to this role.
GRANT OWNERSHIP ON TABLE sensitive_data.PUBLIC.SALARY TO ROLE HR_ROLE;
GRANT OWNERSHIP ON SCHEMA sensitive_data.PUBLIC TO ROLE HR_ROLE;
GRANT OWNERSHIP ON DATABASE sensitive_data TO ROLE HR_ROLE;

 
--validate that no other role can access the data. As the SYSADMIN role try to access the data in this table.
USE ROLE SYSADMIN;
SELECT * FROM sensitive_data.PUBLIC.SALARY;
 
--check if ACCOUNTADMIN role can access the data. 
USE ROLE ACCOUNTADMIN;
SELECT * FROM sensitive_data.PUBLIC.SALARY;
 
--only way to access this data now is to add specific user(s) to the HR_ROLE. We will now create a new user and add that user to the HR_ROLE.
USE ROLE SECURITYADMIN;
CREATE USER hr_user1 PASSWORD = 'password123' MUST_CHANGE_PASSWORD = TRUE;
GRANT ROLE HR_ROLE to USER hr_user1;

--Let us now login as the hr_user1 and see if we can access the salary data.
USE ROLE HR_ROLE;
SELECT * FROM sensitive_data.PUBLIC.SALARY;
