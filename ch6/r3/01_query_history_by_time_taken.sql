
-- list queries ordered by most time taken for execution
USE SNOWFLAKE;
SELECT QUERY_ID, QUERY_TEXT, EXECUTION_TIME,USER_NAME 
FROM SNOWFLAKE.ACCOUNT_USAGE.query_history 
ORDER BY EXECUTION_TIME DESC;


-- use the query id to view query profiles
-- Use the Snowflake WebUI