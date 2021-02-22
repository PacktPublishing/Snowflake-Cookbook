CREATE DATABASE C9_R1;
CREATE TABLE c9r1_date_test (date_id INTEGER, date_value DATE);
INSERT INTO c9r1_date_test (date_id, date_value)
Values
(1, to_date('2019-12-19','YYYY-MM-DD'));

--The DATE datatype is not limited to take dates only. It can take timestamp values as well. But it will ignore the time component of the input.
INSERT INTO c9r1_date_test (date_id, date_value) 
VALUES
(2, TO_TIMESTAMP('2019.12.21 04:00:00', 'YYYY.MM.DD HH:MI:SS'));

--Another variation is to use the to_date function but pass time only. It can take time values, but it assumes the value of Jan 01, 1970 for the date, completely ignoring the time value.
INSERT INTO c9r1_date_test (date_id, date_value) 
VALUES
(3, TO_DATE ('08:00:00', 'HH:MI:SS'));

--select data in the table.
SELECT * FROM c9r1_date_test; 
 

--create a new table with a timestamp type column to demonstrate how Snowflake manages time zones.
CREATE TABLE c9r1_ts_test (ts_id INTEGER, ts_value TIMESTAMP);

--investigate the session object and how it can be used to manage time zones. Session holds various objects where each object has a default value. To find out values of all objects in the session that are related to time zone, run the following command.
SHOW PARAMETERS LIKE '%TIMEZONE%' IN SESSION;

--set the user defined value for time zone to use with data.
ALTER SESSION SET TIMEZONE='Australia/Sydney';

--re-run the command for session to view the updated value..
SHOW PARAMETERS LIKE '%TIMEZONE%' IN SESSION;

--insert a time stamp value.
INSERT INTO c9r1_ts_test (ts_id, ts_value)
VALUES (1, '2020-11-19 22:00:00.000'); 

--select the data from this table by running the following command.
SELECT * FROM c9r1_ts_test; 

--change another session parameter. We shall change how timestamp data is managed by Snowflake. For that we shall be updating the value of the parameter TIMESTAMP_TYPE_MAPPING. 
ALTER SESSION SET TIMESTAMP_TYPE_MAPPING = 'TIMESTAMP_LTZ';
ALTER SESSION SET TIMEZONE = 'Australia/Sydney';
CREATE OR REPLACE TABLE c9r1_test_ts (ts TIMESTAMP);
INSERT INTO c9r1_test_ts VALUES ('2020-11-19 22:00:00.000');
SELECT ts FROM c9r1_test_ts;

--change how the timestamp value with a different time zone is handled. The timestamp value corresponds to a time zone of Australia/Perth (+0800 w.r.t. UTC)
CREATE OR REPLACE TABLE c9r1_test_ts (ts TIMESTAMP);
INSERT INTO c9r1_test_ts VALUES ('2020-11-19 22:00:00.000 +0800');
SELECT ts FROM c9r1_test_ts;
 