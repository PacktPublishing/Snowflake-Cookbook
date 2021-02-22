--create a database
CREATE DATABASE EXPORT_EX;

--Create an internal stage
CREATE OR REPLACE STAGE EXPORT_INTERNAL_STG 
FILE_FORMAT = (TYPE = CSV COMPRESSION=GZIP);

--Extract data from a table into the internal stage
COPY INTO @EXPORT_INTERNAL_STG/customer.csv.gz 
FROM SNOWFLAKE_SAMPLE_DATA.TPCH_SF1.CUSTOMER;

--Validate files are extracted 
LIST @EXPORT_INTERNAL_STG;
 
--Use SnowSQL to download the files to a local directory
GET @EXPORT_INTERNAL_STG 'file://C:/Downloads/';
