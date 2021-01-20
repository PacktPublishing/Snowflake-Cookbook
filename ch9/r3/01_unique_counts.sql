-- perform a SELECT query on Orders table available in the database SNOWFLAKE_DEMO_DB, schema TPCH_SF1000. 
select * 
from "SNOWFLAKE_SAMPLE_DATA"."TPCH_SF1000"."ORDERS"
sample row (1000 rows);

--execute a count on the O_CUSTKEY column while applying grouping on O_ORDERPRIORITY. 
select 
O_ORDERPRIORITY
,count(O_CUSTKEY)
from "SNOWFLAKE_SAMPLE_DATA"."TPCH_SF1000"."ORDERS"
group by 1
order by 1;


--to stop Snowflake from using results from cache , we shall change one setting. We shall alter the session and set USE_CACHED_RESULT to FALSE first
ALTER SESSION SET USE_CACHED_RESULT = FALSE;

--calculate the same count but with a variation this time. We will apply a DISTINCT on the O_CUSTKEY column, so that customers with repeat orders are counted once.
SELECT O_ORDERPRIORITY
,count(DISTINCT O_CUSTKEY)
from "SNOWFLAKE_SAMPLE_DATA"."TPCH_SF1000"."ORDERS"
group by 1
order by 1;

 

--try the same thing but this time, we shall use the APPROX_COUNT_DISTINCT function on the O_CUSTKEY column, rather than the COUNT(DISTINCT …) function used in step 3.
select O_ORDERPRIORITY
,APPROX_COUNT_DISTINCT(O_CUSTKEY)
from "SNOWFLAKE_SAMPLE_DATA"."TPCH_SF100"."ORDERS"
group by 1
order by 1;