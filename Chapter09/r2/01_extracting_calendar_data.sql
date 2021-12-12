--use the seq4() function to generate list of numbers from 0 to 364. These numbers will be added to the first date of year 2021. To generate 365 rows, the following code uses GENERATOR() function in Snowflake. 
SELECT (to_date('2020-01-01') + seq4()) cal_dt
FROM TABLE(GENERATOR(ROWCOUNT => 365));

 
--start adding functions to extract date parts. In this step we will extract day, month and year from the date using DATE_PART() function.
SELECT (to_date('2020-01-01') + seq4()) cal_dt,
DATE_PART(day, cal_dt) as cal_dom, --day of month
DATE_PART(month, cal_dt) as cal_month, --month of year
DATE_PART(year, cal_dt) as cal_year --year
FROM TABLE(GENERATOR(ROWCOUNT => 365));
 
--enhance it with more fields. We are going to add the first and last day of the month, against each date in our dataset. We add two columns as shown in the code listing.
SELECT 
(to_date('2021-01-01') + seq4()) cal_dt
,DATE_PART(day, cal_dt) as cal_dom --day of month
,DATE_PART(month, cal_dt) as cal_month --month of year
,DATE_PART(year, cal_dt) as cal_year --yearSS
,DATE_TRUNC('month', CAL_DT) as cal_first_dom
,DATEADD('day', -1,
  DATEADD('month', 1,
  DATE_TRUNC('month', CAL_DT))) as cal_last_dom 
FROM TABLE(GENERATOR(ROWCOUNT => 365)); 

 
--add the English name of the month to the above dataset. Use the DECODE function to get to the English name of the month as shown in the following code. 
SELECT (to_date('2021-01-01') + seq4()) cal_dt
,DATE_PART(day, cal_dt) as cal_dom --day of month
,DATE_PART(month, cal_dt) as cal_month --month of year
,DATE_PART(year, cal_dt) as cal_year --yearSS
,DATE_TRUNC('month', CAL_DT) cal_first_dom
,DATEADD('day', -1,
  DATEADD('month', 1,
  DATE_TRUNC('month', CAL_DT))) cal_last_dom
,DECODE(CAL_MONTH,
           1, 'January',
           2, 'February',
           3, 'March',
           4, 'April',
           5, 'May',
           6, 'June',
           7, 'July',
           8, 'August',
           9, 'September',
           10, 'October',
           11, 'November',
           12, 'December') as cal_month_name
FROM TABLE(GENERATOR(ROWCOUNT => 365));

 
--add a column to our dataset that captures the end of the quarter against each date. We would be using the DATE_TRUNC function passed with ‘quarter’ parameter to manage this. The process is similar to the used for arriving at the end of the month for each month. The following code shows the new column CAL_QTR_END_DT which represents the last date of the quarter.
SELECT (to_date('2021-01-01') + seq4()) cal_dt
,DATE_PART(day, cal_dt) as cal_dom --day of month
,DATE_PART(month, cal_dt) as cal_month --month of year
,DATE_PART(year, cal_dt) as cal_year --yearSS
,DATE_TRUNC('month', CAL_DT) cal_first_dom
,DATEADD('day', -1,
  DATEADD('month', 1,
  DATE_TRUNC('month', CAL_DT))) cal_last_dom
,DECODE(CAL_MONTH,
           1, 'January',
           2, 'February',
           3, 'March',
           4, 'April',
           5, 'May',
           6, 'June',
           7, 'July',
           8, 'August',
           9, 'September',
           10, 'October',
           11, 'November',
           12, 'December') as cal_month_name
,DATEADD('day', -1,
  DATEADD('month', 3,
  DATE_TRUNC('quarter', CAL_DT))) as CAL_QTR_END_DT
FROM TABLE(GENERATOR(ROWCOUNT => 365));
