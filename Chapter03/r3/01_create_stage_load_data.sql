CREATE DATABASE C4_LD_EX;

-- create the table where the data will be loaded
CREATE TABLE CUSTOMER
(
  FName STRING,
  LName STRING,
  Email STRING,
  Date_Of_Birth DATE,
  City STRING,
  Country STRING
);


-- define the file format which is pipe delimited in case of our sample file
CREATE FILE FORMAT PIPE_DELIM
	TYPE = CSV
	FIELD_DELIMITER = '|'
	FIELD_OPTIONALLY_ENCLOSED_BY = '"'
	SKIP_HEADER = 1
	DATE_FORMAT = 'YYYY-MM-DD';
	
USE C4_LD_EX;
-- Create an internal stage
CREATE STAGE CUSTOMER_STAGE
	FILE_FORMAT = PIPE_DELIM;