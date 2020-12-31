--use the task_history table function which can be used to query the history of task execution. Th
SELECT * FROM TABLE(information_schema.task_history()) 
ORDER BY SCHEDULED_TIME;

 
--query the view to return task history between two timestamps.
SELECT * FROM 
TABLE(information_schema.task_history(
    scheduled_time_range_start=>to_timestamp_ltz('2020-08-13 14:00:00.000 -0700'),
    scheduled_time_range_end=>to_timestamp_ltz('2020-08-13 14:10:00.000 -0700')
)) 
ORDER BY SCHEDULED_TIME;

--use the RESULT_LIMIT parameter.
SELECT * FROM 
TABLE(information_schema.task_history(
       result_limit => 5
)) 
ORDER BY SCHEDULED_TIME;
 
--query the TASK_HISTORY view based on the task name itself. This can be performed by using the TASK_NAME parameter.
SELECT * FROM 
TABLE(information_schema.task_history(
       task_name => 'CLEAR_ORDERING_CUSTOMERS'
)) 
ORDER BY SCHEDULED_TIME;

--combine parameters into a single query as well to narrow down our results
SELECT * FROM 
TABLE(information_schema.task_history(
       task_name => 'CLEAR_ORDERING_CUSTOMERS',
       result_limit => 2
)) 
ORDER BY SCHEDULED_TIME;