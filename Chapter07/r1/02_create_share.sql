-- You will need to use the ACCOUNTADMIN role to create the share
USE ROLE ACCOUNTADMIN;
CREATE SHARE share_trx_data;

-- grant usage on the database & the schema in which our table is contained
-- this step is necessary to subsequently provide access to the table
GRANT USAGE ON DATABASE C7_R1 TO SHARE share_trx_data;
GRANT USAGE ON SCHEMA C7_R1.public TO SHARE share_trx_data;

-- add the transaction table to the share
-- We have provided SELECT permissions on the shared table so the consumer can 
GRANT SELECT ON TABLE C7_R1.public.transactions TO SHARE share_trx_data;

-- allow consumer account access on the Share
-- to find the consumer_account_number look at the URL of the snowflake
-- instance of the consumer. So if the URL is https://drb98231.us-east-1.snowflakecomputing.com/console#/internal/worksheet
-- the consumer account_number is drb98231
ALTER SHARE share_trx_data ADD ACCOUNT=<consumer_account_name_here>;