-- create a new share object
USE ROLE ACCOUNTADMIN;
CREATE SHARE share_cust_data;

-- grant usage on the database & schema containging the view
GRANT USAGE ON DATABASE VIEW_SHR_DB TO SHARE share_cust_data;
GRANT USAGE ON SCHEMA VIEW_SHR_DB.public TO SHARE share_cust_data;

-- we must grant reference_usage on all databases that contain the
-- tables that are used in the view
GRANT REFERENCE_USAGE ON DATABASE C7_R2_DB1 TO SHARE share_cust_data;
GRANT REFERENCE_USAGE ON DATABASE C7_R2_DB2 TO SHARE share_cust_data;

-- grant selct on the customer_info view to the share object
GRANT SELECT ON TABLE VIEW_SHR_DB.public.CUSTOMER_INFO TO SHARE share_cust_data;

-- allow consumer account access on the Share
-- to find the consumer_account_number look at the URL of the snowflake
-- instance of the consumer. So if the URL is https://drb98231.us-east-1.snowflakecomputing.com/console#/internal/worksheet
-- the consumer account_number is drb98231
ALTER SHARE share_cust_data ADD ACCOUNT=<consumer_account_name_here>;

