--Create a new user which we will call marketing_user1. 
USE ROLE SECURITYADMIN;
CREATE USER marketing_user1 PASSWORD='password123' MUST_CHANGE_PASSWORD = TRUE;
 
--login as the marketing_user1 and run the following query to view what is the default role for the user.
SELECT CURRENT_ROLE();
 
 
--login as a user with access to the SECURITYADMIN role and assign a new role to the marketing_user1. 
USE ROLE SECURITYADMIN;
CREATE ROLE MKT_USER;
GRANT ROLE MKT_USER TO USER marketing_user1;
 
--Let us now make the role the default role for the user.
ALTER USER marketing_user1 SET DEFAULT_ROLE = 'MKT_USER';
 
--re-login as the marketing_user1 and run the following query to view what is the default role for the user. 
SELECT CURRENT_ROLE();