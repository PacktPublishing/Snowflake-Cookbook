--try the same action while logged in as a user who has access to the SECURITYADMIN role. 
USE ROLE SECURITYADMIN;
GRANT USAGE ON DATABASE test_database TO ROLE BA_ROLE;
