--start by creating a database, in which we will create our SQL scalar UDFs. 
CREATE DATABASE C10_R1;

--create a quite simple UDF that squares the value that is provided as the input.
CREATE FUNCTION square(val float)
RETURNS float
AS
$$
  val * val
$$
;

--test this function by calling it in a SELECT statement. 
SELECT square(5);


--create a slightly more complicated function that can apply a tax percentage (10% in this case) and return us the profit after tax deduction. 
CREATE FUNCTION profit_after_tax(cost float, revenue float)
RETURNS float
AS
$$
  (revenue - cost) * (1 - 0.1)
$$
;

--call the function with a simple SELECT statement
SELECT profit_after_tax(100,120);

--call this UDF in the SELECT list as well as the WHERE clause.
SELECT DD.D_DATE, SUM(profit_after_tax(SS_WHOLESALE_COST,SS_SALES_PRICE)) AS real_profit 
FROM SNOWFLAKE_SAMPLE_DATA.TPCDS_SF10TCL.STORE_SALES SS 
INNER JOIN SNOWFLAKE_SAMPLE_DATA.TPCDS_SF10TCL.DATE_DIM DD
ON SS.SS_SOLD_DATE_SK = DD.D_DATE_SK
WHERE DD.D_DATE BETWEEN '2003-01-01' AND '2003-12-31' 
AND profit_after_tax(SS_WHOLESALE_COST,SS_SALES_PRICE) < -50
GROUP BY DD.D_DATE;