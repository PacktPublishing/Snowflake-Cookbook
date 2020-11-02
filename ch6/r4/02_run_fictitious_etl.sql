-- as part of the ETL process delete from the interim processing table
DELETE FROM lineitem_interim_processing;

-- as part of the ETL process insert data into the interim processing table
INSERT INTO lineitem_interim_processing
SELECT * FROM 
snowflake_sample_data.tpch_sf1.lineitem
WHERE l_shipdate BETWEEN dateadd(day, -365, to_date('1998-12-31')) AND to_date('1998-12-31');


-- delete last 7 days of data from the target table
DELETE FROM order_reporting WHERE Order_Ship_Date >  dateadd(day, -7, to_date('1998-12-01'));

-- insert data into the target table that
-- wasn't already loaded
INSERT INTO order_reporting
SELECT 
    L_SHIPDATE AS Order_Ship_Date,
    SUM(L_QUANTITY) AS Quantity,
    SUM(L_EXTENDEDPRICE) AS Price,
    SUM(L_EXTENDEDPRICE) AS Discount
FROM lineitem_interim_processing
WHERE Order_Ship_Date NOT IN (SELECT Order_Ship_Date FROM order_reporting)
GROUP BY Order_Ship_Date;

-- as we do not need data in the interim table, we will now delete all the data from it.
DELETE FROM lineitem_interim_processing;