--start by creating a new database
--followed by the creation of a table that will hold some sample customer data
CREATE DATABASE C8_R2;
CREATE TABLE CUSTOMER AS 
SELECT * FROM SNOWFLAKE_SAMPLE_DATA.TPCDS_SF10TCL.CUSTOMER
LIMIT 100000;
 
--validate that data has successfully been populated in the customer table.
SELECT * FROM CUSTOMER LIMIT 100;

--simulate an accidental DELETE
DELETE FROM CUSTOMER;

--Validate that all rows from the table have been deleted. To do so run the following SQL: 
SELECT * FROM CUSTOMER;

--query the query history to identify which query deleted all the rows.
SELECT QUERY_ID, QUERY_TEXT, DATABASE_NAME, SCHEMA_NAME, QUERY_TYPE
FROM TABLE(INFORMATION_SCHEMA.QUERY_HISTORY())
WHERE QUERY_TYPE = 'DELETE' 
AND EXECUTION_STATUS = 'SUCCESS'
AND DATABASE_NAME = 'C8_R2';


--use the timestamp and the BEFORE syntax, to travel back to how the table looked like before the delete was executed.
--replace the query_id with the appropriate query_id from the above statement
SELECT *
FROM CUSTOMER BEFORE
(STATEMENT => '<query_id>');
 
 
--undo the delete by inserting this data back into the table by using time travel. 
INSERT INTO CUSTOMER
SELECT *
FROM CUSTOMER BEFORE
(STATEMENT => '<query_id>');

--Validate that the data has been restored
SELECT * FROM CUSTOMER;