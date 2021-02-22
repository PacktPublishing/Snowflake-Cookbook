--Snowflake provides the function CURRENT_DATE which as the name suggests returns the current date in the default date format. 
SELECT CURRENT_DATE();
 
--combine the output of CURRENT_DATE with other processing logic.
SELECT IFF (  DAYNAME(  CURRENT_DATE() ) IN ( 'Sat', 'Sun'), TRUE, FALSE) as week_end_processing_flag;
 
--Snowflake provides the CURRENT_TIMESTAMP function, which in addition to the date also provides the time component.
SELECT CURRENT_TIMESTAMP();
 
--detect the client that a query is running from, using the CURRENT_CLIENT context function. 
SELECT CURRENT_CLIENT();

 
--find out the region of your snowflake instance.
SELECT CURRENT_REGION();
 
-- use security specific contextual functions, for example the current role function.
SELECT CURRENT_ROLE();
 --combine  CURRENT_ROLE() in your view definitions to provide specific security processing, for example creating views that limit the number of rows based on which role is being used to query.

--Similar to the CURRENT_ROLE() is the CURRENT_USER() function which as the name describes returns the current user.
SELECT CURRENT_USER();
 
--Snowflake provides the current database function which returns the database selected for the session. If there is no database selected the function returns NULL.
USE DATABASE SNOWFLAKE_SAMPLE_DATA;
SELECT CURRENT_DATABASE();
 
--Snowflake provides the current schema function which returns the schema selected for the session. If there is no schema selected the function returns NULL.
USE DATABASE SNOWFLAKE_SAMPLE_DATA;
USE SCHEMA INFORMATION_SCHEMA;
SELECT CURRENT_SCHEMA();

--find out the current warehouse that has been selected to run the query by using the current warehouse function.
SELECT CURRENT_WAREHOUSE();
 
