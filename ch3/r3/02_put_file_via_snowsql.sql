-- using snowsql upload the file from your local computer to the Snowflake internal stage

USE C4_LD_EX;
PUT file://customers.csv @CUSTOMER_STAGE;

-- validate that the file is successfully loaded
LIST @CUSTOMER_STAGE;