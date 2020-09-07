CREATE DATABASE SP_EX;

--create the table where data will be loaded
CREATE TABLE TRANSACTIONS
(
  Transaction_Date DATE,
  Customer_ID NUMBER,
  Transaction_ID NUMBER,
  Amount NUMBER
);

-- create external stage
-- use an S3 integeration object for connecting to the bucket
CREATE OR REPLACE STAGE SP_TRX_STAGE 
url='s3://<bucket>'
STORAGE_INTEGRATION = S3_INTEGRATION;

-- list the stage to validate everything works
LIST @SP_TRX_STAGE;
