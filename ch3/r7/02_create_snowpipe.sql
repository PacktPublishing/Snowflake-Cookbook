-- create a Snowpipe which will be used to load the data
CREATE OR REPLACE PIPE TX_LD_PIPE 
AUTO_INGEST = true
AS COPY INTO TRANSACTIONS FROM @SP_TRX_STAGE
FILE_FORMAT = (TYPE = CSV SKIP_HEADER = 1);


-- Show pipe to see the notification channel
SHOW PIPES LIKE '%TX_LD_PIPE%';