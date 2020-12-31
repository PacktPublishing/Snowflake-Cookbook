--create a staging table to simulate data arriving from outside Snowflake and being processed further through a stream object. 
CREATE DATABASE stream_demo;
USE DATABASE stream_demo;
CREATE TABLE customer_staging
(
  ID INTEGER,
  Name STRING,
  State STRING,
  Country STRING
);

-- create a stream 
CREATE STREAM customer_changes ON TABLE customer_staging;
 
--describe the stream to see what has been created:
DESC STREAM customer_changes;
 
--insert some data into the staging table to simulate data arriving into Snowflake:
INSERT INTO customer_staging VALUES (1,'Jane Doe','NSW','AU');
INSERT INTO customer_staging VALUES (2,'Alpha','VIC','AU');
 
--validate that the data is indeed inserted into the staging table
SELECT * FROM customer_staging;
 
--view how the changing data has been captured through the stream.
SELECT * FROM customer_changes;
 
--we can now process the data from the stream into another table.Create a table first in which we will insert the recorded data.
CREATE TABLE customer
(
  ID INTEGER,
  Name STRING,
  State STRING,
  Country STRING
);

 
--Retrieve data from a stream and insert into table
INSERT INTO customer 
SELECT ID,Name,State,Country 
FROM customer_changes 
WHERE metadata$action = 'INSERT';
 

--validate that correct data is inserted
SELECT * FROM customer;

--find out what happens to the stream after data has been processed from it.
SELECT * FROM customer_changes;
 

--update a row in the staging table.
UPDATE customer_staging SET name = 'John Smith' WHERE ID = 1;
 
--Select the data from the stream to see how an UPDATE appears in a stream
SELECT * FROM customer_changes;