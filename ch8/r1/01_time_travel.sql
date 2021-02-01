--start by creating a new database, followed by the creation of a table that will hold some sample customer data.
CREATE DATABASE C8_R1;
CREATE TABLE CUSTOMER AS 
SELECT * FROM SNOWFLAKE_SAMPLE_DATA.TPCDS_SF10TCL.CUSTOMER
LIMIT 100000;
 
--validate that data has successfully been populated
SELECT * FROM CUSTOMER LIMIT 100;
 
--make note of the current time before running an update on the customer table. We will use this time stamp to see the data as it existed before our update. 
SELECT CURRENT_TIMESTAMP;
 
--run an UPDATE on the customer table.  We will update the email address column for all rows.
UPDATE CUSTOMER SET C_EMAIL_ADDRESS = 'john.doe@gmail.com';
 
--Validate that the email address column has indeed been updated for the whole table.
SELECT DISTINCT C_EMAIL_ADDRESS FROM CUSTOMER;
 
--use the time travel functionality of Snowflake to view the data as it existed before the update. We will use the timestamp and the AT syntax, to travel back to how the table looked like at or before specific time. Replace the time stamp with the timestamp from the previous step
SELECT DISTINCT C_EMAIL_ADDRESS 
FROM CUSTOMER AT 
(TIMESTAMP => '<time_stamp>'::timestamp_tz);
 
--now select all rows from the table and use them in a variety of ways as per your requirements. 
SELECT * 
FROM CUSTOMER AT 
(TIMESTAMP => '<time_stamp>'::timestamp_tz);

--if you are not 100% sure of the time when the update was made, you can use the BEFORE syntax and provide an approximate timestamp.
-- replace <time_stamp> with an approximate timestamp of your choosing
SELECT DISTINCT C_EMAIL_ADDRESS 
FROM CUSTOMER BEFORE 
(TIMESTAMP => '<time_stamp>'::timestamp_tz);