-- List the inbound and outbound shares that are currently present in the system
USE ROLE ACCOUNTADMIN;
SHOW SHARES;

-- Find the share details by running describe. 
-- Always use provider_account.share_name
DESC SHARE <provider_account_number>.SHARE_CUST_DATA;

-- create a database in consumer snowflake instance based on the share.
CREATE DATABASE SHR_CUSTOMER FROM SHARE producer_account_number_here.SHARE_CUST_DATA;

-- Rerun a describe again to validate that the 
-- database has correctly been attached to the share
-- Always use provider_account.share_name
DESC SHARE <provider_account_number>.SHARE_CUST_DATA;

-- validate that you can select from the shared view
SELECT * FROM SHR_CUSTOMER.PUBLIC.CUSTOMER_INFO;

