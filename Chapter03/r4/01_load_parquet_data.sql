CREATE DATABASE C3_R4;

-- create the table in which we will load parquet data
CREATE TABLE TRANSACTIONS 
(
	TRANSACTION_DATE DATE,
	CUSTOMER_ID NUMBER(38,0),
	TRANSACTION_ID NUMBER(38,0),
	AMOUNT NUMBER(38,0)
);

-- define the file format to be Parquet
CREATE FILE FORMAT GEN_PARQ
TYPE = PARQUET
COMPRESSION = AUTO
NULL_IF = ('MISSING','');

-- create external stage over public S3 bucket 
-- where a sample parquet file is already present
CREATE OR REPLACE STAGE C3_R4_STAGE url='s3://snowflake-cookbook/ch3/r4'
FILE_FORMAT = GEN_PARQ;

-- try and list the files in stage
LIST @C3_R4_STAGE;

-- select the data in the stage
SELECT $1 FROM @C3_R4_STAGE;

-- use the special syntax to access fields in the data
-- convert them to the proper data type & insert into target table
INSERT INTO TRANSACTIONS
SELECT 
$1:_COL_0::Date,
$1:_COL_1::NUMBER,
$1:_COL_2::NUMBER,
$1:_COL_3::NUMBER 

FROM @C3_R4_STAGE;

 
-- Validate data is successfully loaded
USE C3_R4;
SELECT * FROM TRANSACTIONS;
 
