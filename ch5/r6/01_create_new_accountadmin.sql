--Create a new user that we will give the ACCOUTNADMIN role using the syntax below. 
--Make sure that you provide a valid email address for the user. 
--The email address will be used in next steps to set up multi factor authentication.
USE ROLE SECURITYADMIN;

CREATE USER second_account_admin 
PASSWORD = 'password123' 
EMAIL = 'john@doe.com'
MUST_CHANGE_PASSWORD = TRUE;
 
--grant the ACCOUNTADMIN role to the newly created user. 
GRANT ROLE ACCOUNTADMIN TO USER second_account_admin; 
 
--configure the default role for the newly created user. 
--We will setup the default role of the new user to be SECURITYADMIN rather than ACCOUNTADMIN, to ensure that there is no inadvertent use of the ACCOUNTADMIN role.  
ALTER USER second_account_admin
SET DEFAULT_ROLE = SECURITYADMIN; 
