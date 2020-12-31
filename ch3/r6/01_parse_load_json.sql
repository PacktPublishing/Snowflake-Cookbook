CREATE DATABASE NDJSON_EX;

-- create a stage pointing to the S3 bucket containing our example file
CREATE OR REPLACE STAGE NDJSON_STG url='s3://snowflake-cookbook/ch3/r7'
FILE_FORMAT = (TYPE = JSON, STRIP_OUTER_ARRAY = TRUE);

-- list & validate that you can see the json file
LIST @NDJSON_STG;

-- parse the JSON
SELECT  PARSE_JSON($1)
FROM @NDJSON_STG;
 
-- parse and convert the JSON into relational format
SELECT  PARSE_JSON($1):CreditCardNo::String AS CreditCardNo
        ,PARSE_JSON($1):CreditCardHolder::String AS CreditCardHolder
        ,PARSE_JSON($1):CardPin::Integer AS CardPin
        ,PARSE_JSON($1):CardExpiry::String AS CardExpiry
        ,PARSE_JSON($1):CardCVV::String AS CardCVV
FROM @NDJSON_STG;
 
-- create a new table with the JSON data
CREATE TABLE CREDIT_CARD_DATA AS
SELECT  PARSE_JSON($1):CreditCardNo::String AS CreditCardNo
        ,PARSE_JSON($1):CreditCardHolder::String AS CreditCardHolder
        ,PARSE_JSON($1):CardPin::Integer AS CardPin
        ,PARSE_JSON($1):CardExpiry::String AS CardExpiry
        ,PARSE_JSON($1):CardCVV::String AS CardCVV
FROM @NDJSON_STG;

-- validate data inserted successfully
SELECT * FROM CREDIT_CARD_DATA;
 
