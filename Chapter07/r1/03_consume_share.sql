-- List the inbound and outbound shares that are currently present in the system
USE ROLE ACCOUNTADMIN;
SHOW SHARES;

-- Find the share details by running describe. 
-- Always use provider_account.share_name
DESC SHARE <provider_account_name_here>.SHARE_TRX_DATA;


-- create a database in consumer snowflake instance based on the share.
CREATE DATABASE SHR_TRANSACTIONS FROM SHARE <provider_account_name_here>.SHARE_TRX_DATA;


--validate that the database is attached to the share.
DESC SHARE <provider_account_name_here>.SHARE_TRX_DATA;


-- query the table to confirm you can select data as a consumer
SELECT * FROM SHR_TRANSACTIONS.PUBLIC.TRANSACTIONS;
