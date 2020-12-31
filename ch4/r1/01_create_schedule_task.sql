--fictitious query on the sample data
SELECT C.C_NAME,SUM(L_EXTENDEDPRICE),SUM(L_TAX) 

FROM SNOWFLAKE_SAMPLE_DATA.TPCH_SF1.CUSTOMER C 

INNER JOIN SNOWFLAKE_SAMPLE_DATA.TPCH_SF1.ORDERS O
ON O.O_CUSTKEY = C.C_CUSTKEY

INNER JOIN SNOWFLAKE_SAMPLE_DATA.TPCH_SF1.LINEITEM LI
ON LI.L_ORDERKEY = O.O_ORDERKEY

GROUP BY C.C_NAME;


--create a target table for this query
CREATE DATABASE task_demo;
USE DATABASE task_demo;
CREATE TABLE ordering_customers
(
  Reporting_Time TIMESTAMP,
  Customer_Name STRING,
  Revenue NUMBER(16,2),
  Tax NUMBER(16,2)
);

--create a task using the preceding SQL statement
CREATE TASK refresh_ordering_customers
  WAREHOUSE = COMPUTE_WH
  SCHEDULE = '30 MINUTE'
  COMMENT = 'Update Ordering_Customers Table with latest data'
AS
  INSERT INTO ordering_customers
  SELECT CURRENT_TIMESTAMP, C.C_NAME, 
         SUM(L_EXTENDEDPRICE), SUM(L_TAX)
  FROM SNOWFLAKE_SAMPLE_DATA.TPCH_SF1.CUSTOMER C 
  INNER JOIN SNOWFLAKE_SAMPLE_DATA.TPCH_SF1.ORDERS O
  ON O.O_CUSTKEY = C.C_CUSTKEY
  INNER JOIN SNOWFLAKE_SAMPLE_DATA.TPCH_SF1.LINEITEM LI
  ON LI.L_ORDERKEY = O.O_ORDERKEY
  GROUP BY CURRENT_TIMESTAMP, C.C_NAME;

--validate that the Task has been created correctly
DESC TASK refresh_ordering_customers;


-- grant privileges to the SYSADMIN 
USE ROLE ACCOUNTADMIN;
GRANT EXECUTE TASK ON ACCOUNT TO ROLE SYSADMIN;
 
--set the task status to Resumed so that it can start executing on schedule.
ALTER TASK refresh_ordering_customers RESUME;
DESC TASK refresh_ordering_customers;

 
--run the followin to keep an eye on the task execution to validate that it runs successfully. 
SELECT name, state,
        completed_time, scheduled_time, 
        error_code, error_message
        
FROM TABLE(information_schema.task_history())
WHERE name = 'REFRESH_ORDERING_CUSTOMERS';

--validate that the task has indeed executed successfully by selecting from the ordering_customers table.
SELECT * FROM ordering_customers;
 
