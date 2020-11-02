-- find queries that are alike by grouping on the hash of the query text

USE SNOWFLAKE;

SELECT QUERY_TEXT, USER_NAME, HASH(QUERY_TEXT) AS PUESODO_QUERY_ID , 
COUNT(*) AS NUM_OF_QUERIES, SUM(EXECUTION_TIME) AS AGG_EXECUTION_TIME

FROM SNOWFLAKE.ACCOUNT_USAGE.query_history 
GROUP BY QUERY_TEXT, USER_NAME
ORDER BY AGG_EXECUTION_TIME DESC;

-- find the query id
USE SNOWFLAKE;
SELECT QUERY_ID, QUERY_TEXT, USER_NAME, HASH(QUERY_TEXT) AS PUESODO_QUERY_ID

FROM SNOWFLAKE.ACCOUNT_USAGE.query_history 
WHERE PUESODO_QUERY_ID = <puesodo query id from previous step>;

-- use the query id to view query profiles
-- Use the Snowflake WebUI
