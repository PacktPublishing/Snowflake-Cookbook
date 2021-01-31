CREATE DATABASE C6_R1;

-- create the table where the data will be loaded
CREATE TABLE CUSTOMER
(
  CustomerID VARCHAR(100),
  FName VARCHAR(1024),
  LName VARCHAR(1024),
  Email VARCHAR(1024),
  Date_Of_Birth VARCHAR(1024),
  City VARCHAR(1024),
  Country VARCHAR(1024)
);


-- define the file format
CREATE FILE FORMAT CSV_FORMAT
	TYPE = CSV
	FIELD_DELIMITER = ','
	FIELD_OPTIONALLY_ENCLOSED_BY = '"'
	SKIP_HEADER = 1
	DATE_FORMAT = 'YYYY-MM-DD';
	

-- create an external stage using a sample S3 bucket
-- In real world scenario replace the url with your cloud storage URL
CREATE OR REPLACE STAGE C6_R1_STAGE url='s3://snowflake-cookbook/ch6/r1'
FILE_FORMAT = CSV_FORMAT;

-- list the files in the stage 
LIST @C6_R1_STAGE;

-- copy the data from the stage into the table
COPY INTO CUSTOMER
FROM @C6_R1_STAGE;

-- see table sizes
SHOW TABLES;

-- create another table with optimised structure
CREATE TABLE CUSTOMER_OPT
(
  CustomerID DECIMAL(10,0),
  FName VARCHAR(50),
  LName VARCHAR(50),
  Email VARCHAR(50),
  Date_Of_Birth DATE,
  City VARCHAR(50),
  Country VARCHAR(50)
);

-- copy the data from the stage into the table
COPY INTO CUSTOMER_OPT
FROM @C6_R1_STAGE;

-- review and compare the two table sizes
SHOW TABLES;
