-- Login as the dev_dba_user1 and try to select from the customer table. 
USE ROLE DEV_DBA;
USE DATABASE DEV;
SELECT * FROM CUSTOMER;