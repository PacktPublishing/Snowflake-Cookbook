-- create database where we will create views
CREATE DATABASE test_view_creation;

-- create a sample view
CREATE VIEW test_view_creation.public.date_wise_orders
AS
SELECT L_COMMITDATE AS ORDER_DATE,
SUM(L_QUANTITY) AS TOT_QTY,
SUM(L_EXTENDEDPRICE) AS TOT_PRICE
FROM SNOWFLAKE_SAMPLE_DATA.TPCH_SF1000.LINEITEM
GROUP BY L_COMMITDATE;

-- select from the view to validate view works
SELECT * FROM test_view_creation.public.date_wise_orders; 


-- create the view as materialized
CREATE MATERIALIZED VIEW test_view_creation.public.date_wise_orders_fast
AS
SELECT L_COMMITDATE AS ORDER_DATE,
SUM(L_QUANTITY) AS TOT_QTY,
SUM(L_EXTENDEDPRICE) AS TOT_PRICE
FROM SNOWFLAKE_SAMPLE_DATA.TPCH_SF1000.LINEITEM
GROUP BY L_COMMITDATE;

-- select from materialized view which is much faster
SELECT * FROM test_view_creation.public.date_wise_orders_fast;
