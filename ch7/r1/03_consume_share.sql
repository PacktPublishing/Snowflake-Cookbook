-- List the inbound and outbound shares that are currently present in the system
USE ROLE ACCOUNTADMIN;
SHOW SHARES;

-- Find the share details by running describe. 
-- Always use provider_account.share_name
DESC SHARE <provider_account_number>.SHARE_TRX_DATA;

-- create a database in consumer snowflake instance based on the share.
CREATE DATABASE SHR_TRANSACTIONS FROM SHARE producer_account_number_here.SHARE_TRX_DATA;
