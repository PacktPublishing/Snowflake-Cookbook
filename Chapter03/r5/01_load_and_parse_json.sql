CREATE DATABASE JSON_EX;

-- create external stage pointing to 
-- the public bucket where we have palced a sample JSON file
CREATE OR REPLACE STAGE JSON_STG url='s3://snowflake-cookbook/ch3/r5'
FILE_FORMAT = (TYPE = JSON);

-- validate that you can access the bucket
LIST @JSON_STG;
 
-- check that you can load and parse the JSON
SELECT  PARSE_JSON($1)
FROM @JSON_STG;
 
-- create a new table in which we will load the JSON data
CREATE TABLE CREDIT_CARD_TEMP
(
    MY_JSON_DATA VARIANT
);

-- copy the JSON data into the table
COPY INTO CREDIT_CARD_TEMP
FROM @JSON_STG;

-- parse and start making sense of JSON fields
SELECT MY_JSON_DATA:data_set,MY_JSON_DATA:extract_date FROM CREDIT_CARD_TEMP;

-- access the credit_cards array in JSON
SELECT MY_JSON_DATA:credit_cards FROM CREDIT_CARD_TEMP;

-- access specific values in credit_cards array in JSON
SELECT MY_JSON_DATA:credit_cards[0].CreditCardNo,MY_JSON_DATA:credit_cards[0].CreditCardHolder FROM CREDIT_CARD_TEMP;

-- use FLATTEN function to conver JSON into relational format
SELECT
    MY_JSON_DATA:extract_date,
    value:CreditCardNo::String,
    value:CreditCardHolder::String,
    value:CardPin::Integer,
    value:CardCVV::String,
    value:CardExpiry::String
FROM
    CREDIT_CARD_TEMP
    , lateral flatten( input => MY_JSON_DATA:credit_cards );
 