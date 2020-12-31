--We will be using a fictitious query on the sample data
SELECT C.C_NAME,SUM(L_EXTENDEDPRICE),SUM(L_TAX) 

FROM SNOWFLAKE_SAMPLE_DATA.TPCH_SF1.CUSTOMER C 

INNER JOIN SNOWFLAKE_SAMPLE_DATA.TPCH_SF1.ORDERS O
ON O.O_CUSTKEY = C.C_CUSTKEY

INNER JOIN SNOWFLAKE_SAMPLE_DATA.TPCH_SF1.LINEITEM LI
ON LI.L_ORDERKEY = O.O_ORDERKEY

GROUP BY C.C_NAME;

--create a target table for this query where we will save the results of this query. 
CREATE DATABASE task_demo;
USE DATABASE task_demo;
CREATE TABLE ordering_customers
(
  Customer_Name STRING,
  Revenue NUMBER(16,2),
  Tax NUMBER(16,2)
);

--create an initialization task to clean up the table before we insert new data into the table. 
USE DATABASE task_demo;
CREATE TASK clear_ordering_customers
  WAREHOUSE = COMPUTE_WH
  COMMENT = 'Delete from Ordering_Customers'
AS
 DELETE FROM task_demo.public.ordering_customers;
 
	 
--create a task using the SQL statement in step 1 to insert data into the ordering_customers table.
CREATE TASK insert_ordering_customers
  WAREHOUSE = COMPUTE_WH
  COMMENT = 'Insert into Ordering_Customers the latest data'
AS
  INSERT INTO ordering_customers
  SELECT C.C_NAME, SUM(L_EXTENDEDPRICE), SUM(L_TAX)
  FROM SNOWFLAKE_SAMPLE_DATA.TPCH_SF1.CUSTOMER C 
  INNER JOIN SNOWFLAKE_SAMPLE_DATA.TPCH_SF1.ORDERS O
  ON O.O_CUSTKEY = C.C_CUSTKEY
  INNER JOIN SNOWFLAKE_SAMPLE_DATA.TPCH_SF1.LINEITEM LI
  ON LI.L_ORDERKEY = O.O_ORDERKEY
  GROUP BY C.C_NAME;
 
--We will now make the insert task to run after the clear task.
ALTER TASK insert_ordering_customers 
ADD AFTER clear_ordering_customers; 

--run a describe on the task to validate the tasks have been connected.
DESC TASK insert_ordering_customers; 
 
--schedule our clear_ordering_customers task to execute on a schedule. 
ALTER TASK clear_ordering_customers 
SET SCHEDULE = '10 MINUTE'; 

--If you are running your code through a role other than ACCOUNTADMIN you must grant that role the privilege to execute task. 
GRANT EXECUTE TASK ON ACCOUNT TO ROLE SYSADMIN;
 
--set the tasks to Resume since tasks are created as suspended by default and would not work unless we set them to resume. 
ALTER TASK insert_ordering_customers RESUME;
ALTER TASK clear_ordering_customers RESUME;

--keep an eye on the task execution to validate that it runs successfully.
SELECT name, state,
        completed_time, scheduled_time, 
        error_code, error_message
        
FROM TABLE(information_schema.task_history())
WHERE name IN ('CLEAR_ORDERING_CUSTOMERS','RELOAD_ORDERING_CUSTOMERS');
 
--After 10 minutes, re-run the preceding query
 
--validate that the tasks have indeed executed successfully by selecting from the ordering_customers table:
SELECT * FROM ordering_customers;