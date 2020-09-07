CREATE DATABASE C3_R4;

-- create the table in which we will load parquet data
CREATE TABLE TRANSACTIONS
(
  FName STRING,
  LName STRING,
  Email STRING,
  Date_Of_Birth DATE,
  City STRING,
  Country STRING
);

-- define the file format to be Parquet
CREATE FILE FORMAT GEN_PARQ
TYPE = PARQUET
COMPRESSION = AUTO
NULL_IF = ('MISSING','');

-- create external stage over public S3 bucket 
-- where a sample parquet file is already present
CREATE OR REPLACE STAGE C3_R4_STAGE url='s3://snowflake-cookbook/ch3/r4';

-- try and list the files in stage
LIST @C3_R4_STAGE;

-- load the data from external stage into transaction table
COPY INTO TRANSACTIONS
FROM @ C3_R4_STAGE;

 
-- Validate data is successfully loaded
USE C4_LD_EX;
SELECT * FROM CUSTOMER;
 
