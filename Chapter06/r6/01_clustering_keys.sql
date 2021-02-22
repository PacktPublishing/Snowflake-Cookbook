--Create a new database
CREATE DATABASE C6_R6;

-- create table that will hold the transaction data:
CREATE TABLE TRANSACTIONS
(
  TXN_ID STRING,
  TXN_DATE DATE,
  CUSTOMER_ID STRING,
  QUANTITY DECIMAL(20),
  PRICE DECIMAL(30,2),
  COUNTRY_CD STRING
);

--Populate this table with dummy data using the SQL given in the code block that follows. 
--Run this step 8-10 times repeatedly to ensure that a large amount of data is inserted into the TRANSACTIONS table and many micro partitions are created. 
INSERT INTO TRANSACTIONS
SELECT
    UUID_STRING() AS TXN_ID
    ,DATEADD(DAY,UNIFORM(1, 500, RANDOM()) * -1, '2020-10-15') AS TXN_DATE
    ,UUID_STRING() AS CUSTOMER_ID
    ,UNIFORM(1, 10, RANDOM()) AS QUANTITY
    ,UNIFORM(1, 200, RANDOM()) AS PRICE
    ,RANDSTR(2,RANDOM()) AS COUNTRY_CD
FROM TABLE(GENERATOR(ROWCOUNT => 10000000));

--run a sample query simulating a report that needs to access the last 30 days of data and check the profile of this query
SELECT * FROM TRANSACTIONS 
WHERE TXN_DATE BETWEEN DATEADD(DAY, -31, '2020-10-15') AND '2020-10-15';

--change the clustering key to TXN_DATE. 
ALTER TABLE TRANSACTIONS CLUSTER BY ( TXN_DATE );

--re-run the same query and investigate if the clustering key has improved performance
SELECT * FROM TRANSACTIONS 
WHERE TXN_DATE BETWEEN DATEADD(DAY, -31, '2020-10-15') AND '2020-10-15';