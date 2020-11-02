-- run an inefficient query that takes too long to run
-- and consumes un-necessary credits
USE SCHEMA SNOWFLAKE_SAMPLE_DATA.TPCDS_SF10TCL;

SELECT *
FROM store_returns,date_dim
WHERE sr_returned_date_sk = d_date_sk;
