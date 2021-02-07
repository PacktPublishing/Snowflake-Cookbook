--start by creating a database, in which we will create our SQL tabular UDFs.
CREATE DATABASE C10_R2;
USE DATABASE C10_R2;
USE SCHEMA PUBLIC;

--run an out of the box table function provided by Snowflake to see how to call table functions
SELECT *
FROM TABLE(information_schema.query_history_by_session())
ORDER BY start_time;

 
--create a quite simple table function using SQL. The function will return the name of a location and the time zone that the location has. To keep things simple, we will use hard coded values. 
CREATE FUNCTION LocationTimeZone()
RETURNS TABLE(LocationName String, TimeZoneName String)
as
$$
    SELECT 'Sydney', 'GMT+11'
    UNION
    SELECT 'Auckland', 'GMT+13'
    UNION
    SELECT 'Islamabad', 'GMT+5'
    UNION
    SELECT 'London', 'GMT'
$$;

--call this function.
SELECT * FROM TABLE(LocationTimeZone());

 --you can treat this output as any other relational table, so you can add where clauses and select only particular columns. To do so run the following SQL:
SELECT TimeZoneName FROM TABLE(LocationTimeZone())
WHERE LocationName = 'Sydney';

--We do not have to hardcode values in a table function but rather we can select from existing tables and even join tables with-in our function definition. Let’s create such a table function which joins data from two table to produce an output.
CREATE FUNCTION CustomerOrders()
RETURNS TABLE(CustomerName String, TotalSpent Number(12,2))
as
$$
    SELECT C.C_NAME AS CustomerName, SUM(O.O_TOTALPRICE) AS TotalSpent
    FROM SNOWFLAKE_SAMPLE_DATA.TPCH_SF1.ORDERS O 
    INNER JOIN SNOWFLAKE_SAMPLE_DATA.TPCH_SF1.CUSTOMER C
    ON C.C_CUSTKEY = O.O_CUSTKEY
    GROUP BY C.C_NAME
$$;

--call this function to review the output. 
SELECT * FROM TABLE(CustomerOrders());


--alter the function so that it can take customer name as a parameter. 
CREATE FUNCTION CustomerOrders(CustomerName String)
RETURNS TABLE(CustomerName String, TotalSpent Number(12,2))
as
$$
    SELECT C.C_NAME AS CustomerName, SUM(O.O_TOTALPRICE) AS TotalSpent
    FROM SNOWFLAKE_SAMPLE_DATA.TPCH_SF1.ORDERS O 
    INNER JOIN SNOWFLAKE_SAMPLE_DATA.TPCH_SF1.CUSTOMER C
    ON C.C_CUSTKEY = O.O_CUSTKEY
    WHERE C.C_NAME = CustomerName
    GROUP BY C.C_NAME
$$;

--it is important to understand that we have created two functions here. One function called CustomerOrders that does not take any parameter and another with the same name that accepts the name as a parameter. To demonstrate this run the following SQL.
SHOW FUNCTIONS LIKE '%CustomerOrders%';


--Let us now call the new function by passing in a customer name as a paramter.
SELECT * FROM TABLE(CustomerOrders('Customer#000062993'));