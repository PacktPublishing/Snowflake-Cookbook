-- Create an External Stage
-- Use the storage integration you would have previously created
CREATE OR REPLACE STAGE EXPORT_EXTERNAL_STG 
url='s3://<bucket>'
STORAGE_INTEGRATION = S3_INTEGRATION
FILE_FORMAT = (TYPE = PARQUET COMPRESSION=AUTO);;

--Extract data from a table into the external stage
COPY INTO @EXPORT_EXTERNAL_STG/customer.parquet 
FROM (SELECT * FROM SNOWFLAKE_SAMPLE_DATA.TPCH_SF1.CUSTOMER SAMPLE (10));
 
