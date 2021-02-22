--create if not exists
create database chapter9; 
use chapter9;

-- The view has the logic to generate 365 records
create or replace view c9r5_vw as 
select
    mod(seq4(),5) as customer_id
    ,(mod(uniform(1,100,random()),5) + 1)*100 as deposit
    ,dateadd(day, '-' || seq4(), current_date()) as deposit_dt
from
  table
    (generator(rowcount => 365));

--use this dataset to run a few window functions available in Snowflake.
SELECT
      customer_id,
      deposit_dt,
deposit,
      deposit > 
      COALESCE(SUM(deposit) OVER (
                 PARTITION BY customer_id 
                 ORDER BY deposit_dt
            	ROWS BETWEEN 2 PRECEDING AND 1 PRECEDING)
       , 0) AS hi_deposit_alert
FROM 
     c9r5_vw
ORDER BY 
      customer_id, deposit_dt desc;

--change the window range and use average rather than sum in this example. 
SELECT
      customer_id,
      deposit_dt,
      deposit,
      COALESCE(AVG(deposit) OVER (
                 PARTITION BY customer_id 
                 ORDER BY deposit_dt
            	ROWS BETWEEN UNBOUNDED PRECEDING AND 1 PRECEDING)
       , 0) as past_average_deposit,
      deposit >  past_average_deposit AS hi_deposit_alert
FROM 
     c9r5_vw
     
WHERE CUSTOMER_ID = 3
ORDER BY 
      customer_id, deposit_dt desc;
