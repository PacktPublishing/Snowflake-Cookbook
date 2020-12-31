--create a database and a staging table on which we will create our stream object. We will be creating a staging table to simulate data arriving from outside Snowflake and being processed further through a stream object. 
CREATE DATABASE stream_demo;
USE DATABASE stream_demo;
CREATE TABLE customer_staging
(
  ID INTEGER,
  Name STRING,
  State STRING,
  Country STRING
);

 
--create a stream on the table that captures only the inserts.
CREATE STREAM customer_changes ON TABLE customer_staging APPEND_ONLY = TRUE;

 --describe the stream to see what has been created. 
DESC STREAM customer_changes;
 
--create the actual table where all the new customer data will be processed into.
CREATE TABLE customer
(
  ID INTEGER,
  Name STRING,
  State STRING,
  Country STRING
);
 
--create a task which we will use to insert any new data that appears in the stream. 
CREATE TASK process_new_customers
  WAREHOUSE = COMPUTE_WH
  COMMENT = 'Process new data into customer'
AS
  INSERT INTO customer 
SELECT ID,Name,State,Country 
FROM customer_changes 
WHERE metadata$action = 'INSERT';
 
--schedule this task to run every 5 minutes.

--Please note that to RESUME a task you will need to run the command as ACCOUTNADMIN or another role with the appropriate privilege. 
ALTER TASK process_new_customers 
SET SCHEDULE = '10 MINUTE'; 
ALTER TASK process_new_customers RESUME;
 
--validate that the target table i.e. customer is empty.
SELECT * FROM customer;
 

--after 5 mins view how the changing data has been captured through the stream.
SELECT * FROM customer_changes;
 
--now insert some data into the staging table 
INSERT INTO customer_staging VALUES (1,'Jane Doe','NSW','AU');
INSERT INTO customer_staging VALUES (2,'Alpha','VIC','AU');

-- retrieve data from a stream and insert into target table. 
--Do note that we have used a where clause on the metadata$action equal to INSERT. This is to ensure that we only process new data.
INSERT INTO customer 
SELECT ID,Name,State,Country 
FROM customer_changes 
WHERE metadata$action = 'INSERT';
 
--select the data from the customer table to validate that correct data appears there.
SELECT * FROM customer;
 
--We will now insert some data into the staging table (effectively simulating data that has arrived into Snowflake from an external source).
INSERT INTO customer_staging VALUES (3,'Mike','ACT','AU');
INSERT INTO customer_staging VALUES (4,'Tango','NT','AU');
 
--wait for our scheduled task to run, which will process this staging data into the target table. 
--keep an eye on the execution and the next scheduled time by running the following query. 
SELECT * FROM 
TABLE(information_schema.task_history(
       task_name => 'PROCESS_NEW_CUSTOMERS'
)) 
ORDER BY SCHEDULED_TIME DESC;

--select the data from the target table to validate that the rows in the staging table have been inserted into the target table. 
SELECT * FROM customer;
 
