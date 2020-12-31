-- create a table 
CREATE TABLE customers (
  id              INT NOT NULL,
  last_name       VARCHAR(100) ,
  first_name      VARCHAR(100),
  email           VARCHAR(100),
  company         VARCHAR(100),
  phone           VARCHAR(100),
  address1        VARCHAR(150),
  address2        VARCHAR(150),
  city            VARCHAR(100),
  state           VARCHAR(100),
  postal_code     VARCHAR(15),
  country         VARCHAR(50)
);


-- replace the table
CREATE OR REPLACE TABLE customers (
  id              INT NOT NULL,
  last_name       VARCHAR(100) ,
  first_name      VARCHAR(100),
  email           VARCHAR(100),
  company         VARCHAR(100),
  phone           VARCHAR(100),
  address1        STRING,
  address2        STRING,
  city            VARCHAR(100),
  state           VARCHAR(100),
  postal_code     VARCHAR(15),
  country         VARCHAR(50)
);

-- load sample data
COPY INTO customers
FROM s3://snowflake-cookbook/ch2/r3/customer.csv
FILE_FORMAT = (TYPE = csv SKIP_HEADER = 1 FIELD_OPTIONALLY_ENCLOSED_BY = '"');


-- replace table selecting all data from the customer table
CREATE OR REPLACE TABLE 
	customers_deep_copy 
AS 
SELECT * 
	FROM customers;


-- replace table selecting without data
CREATE OR REPLACE TABLE 
customers_shallow_copy 
LIKE customers;


SELECT 
COUNT(*) shallow_count 
FROM 
customers_shallow_copy;

-- create a temporary table
CREATE TEMPORARY TABLE customers_temp AS SELECT * FROM customers WHERE TRY_TO_NUMBER(postal_code) IS NOT NULL;

-- create a transient table
CREATE TRANSIENT TABLE customers_trans AS AS SELECT * FROM customers WHERE TRY_TO_NUMBER(postal_code) IS NULL;
