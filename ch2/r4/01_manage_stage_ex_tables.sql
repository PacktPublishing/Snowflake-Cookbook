-- create a stage
create or replace stage sfuser_ext_stage
url='s3://snowflake-cookbook/ch2/r4/';

-- list the files in the stage
list@SFUSER_EXT_STAGE;
	

-- create an external table
create or replace external table ext_tbl_userdata1
with location = @sfuser_ext_stage                                                                      
file_format = (type = parquet);


-- select from the external table
select * from ext_tbl_userdata1;

-- create external table with CSV data
create or replace external table ext_card_data
with location = @sfuser_ext_stage/csv
file_format = (type = csv)
pattern = '.*headless[.]csv';

select * from ext_card_data; 

-- translate JSON data from external table into a relational format
select top 5 value:c3::float as card_sum,
value:c2::string as period 
from ext_card_data;

drop table ext_card_data;

drop table ext_tbl_userdata1;