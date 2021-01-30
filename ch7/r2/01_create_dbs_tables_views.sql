-- create first database which will contain the customer table
CREATE DATABASE C7_R2_DB1;

-- creation of a table which will hold the customer data.
CREATE TABLE CUSTOMER
(
  CUST_ID NUMBER,
  CUST_NAME STRING
);

--populate this table with a thousand rows of dummy data 
INSERT INTO CUSTOMER
SELECT
    SEQ8() AS CUST_ID,
	RANDSTR(10,RANDOM()) AS CUST_NAME
FROM TABLE(GENERATOR(ROWCOUNT => 1000));


-- create second database which will contain the customer address table
CREATE DATABASE C7_R2_DB2;

-- creation of a table which will hold the customer address data.
CREATE TABLE CUSTOMER_ADDRESS
(
  CUST_ID NUMBER,
  CUST_ADDRESS STRING
);

--populate this table with thousand rows of dummy data 
INSERT INTO CUSTOMER_ADDRESS
SELECT
    SEQ8() AS CUST_ID,
	RANDSTR(50,RANDOM()) AS CUST_ADDRESS
FROM TABLE(GENERATOR(ROWCOUNT => 1000));


-- create a seprate database which will contain a view that joins 
-- the customer & the customer address table
CREATE DATABASE VIEW_SHR_DB;

-- create a view joining customer and customer address table
-- notice the view has to be created as a Secure View since
-- only Secure Views can be shared
CREATE SECURE VIEW CUSTOMER_INFO AS
SELECT CUS.CUST_ID, CUS.CUST_NAME, CUS_ADD.CUST_ADDRESS 
FROM C7_R2_DB1.PUBLIC.CUSTOMER CUS
INNER JOIN C7_R2_DB2.PUBLIC.CUSTOMER_ADDRESS CUS_ADD
ON CUS.CUST_ID = CUS_ADD.CUST_ID;

-- Validate that the view is working
SELECT * FROM CUSTOMER_INFO;