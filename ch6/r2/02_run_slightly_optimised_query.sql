-- replace the SELECT * with a column list
-- and review through query profile how big a difference this makes
USE SCHEMA SNOWFLAKE_SAMPLE_DATA.TPCDS_SF10TCL;

SELECT 
d_year
,sr_customer_sk as ctr_customer_sk
,sr_store_sk as ctr_store_sk
,SR_RETURN_AMT_INC_TAX

FROM store_returns,date_dim
WHERE sr_returned_date_sk = d_date_sk;
