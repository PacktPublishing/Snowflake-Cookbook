-- create a table 
CREATE TABLE customers (
  id              INT NOT NULL,
  last_name       VARCHAR(50) ,
  first_name      VARCHAR(50),
  email           VARCHAR(50),
  company         VARCHAR(50),
  phone           VARCHAR(25),
  address1        VARCHAR(150),
  address2        VARCHAR(150),
  city            VARCHAR(50),
  state           VARCHAR(50),
  postal_code     VARCHAR(15),
  country         VARCHAR(50)
);

-- replace the table
CREATE OR REPLACE TABLE customers (
  id              INT NOT NULL,
  last_name       VARCHAR(50) ,
  first_name      VARCHAR(50),
  email           VARCHAR(50),
  company         VARCHAR(50),
  phone           VARCHAR(25),
  address1        STRING,
  address2        STRING,
  city            VARCHAR(50),
  state           VARCHAR(50),
  postal_code     VARCHAR(15),
  country         VARCHAR(50)
);

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