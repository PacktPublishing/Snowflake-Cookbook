CREATE DATABASE C3_R2;
USE C3_R2;

-- create the table into which sample data will be loaded
CREATE TABLE CREDIT_CARDS
(
  CUSTOMER_NAME STRING,
  CREDIT_CARD STRING,
  TYPE STRING,
  CCV INTEGER,
  EXP_DATE STRING
);

-- define the CSV file format
CREATE FILE FORMAT GEN_CSV
TYPE = CSV
SKIP_HEADER = 1
FIELD_OPTIONALLY_ENCLOSED_BY = '"';

-- create an external stage using a sample S3 bucket
-- In real world scenario replace the url with your cloud storage URL
CREATE OR REPLACE STAGE C3_R2_STAGE url='s3://snowflake-cookbook/ch3/r2'
FILE_FORMAT = GEN_CSV;

-- list the files in the stage 
LIST @C3_R2_STAGE;

-- copy the data from the stage into the table
COPY INTO CREDIT_CARDS
FROM @C3_R2_STAGE;


-- validate that the data loaded successfully 
USE C3_R2;
SELECT COUNT(*) FROM CREDIT_CARDS;