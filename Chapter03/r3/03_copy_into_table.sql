USE C4_LD_EX;

-- copy from internal stage into the table
COPY INTO CUSTOMER
FROM @CUSTOMER_STAGE;

-- validate that the data is successfully loaded
USE C4_LD_EX;
SELECT * FROM CUSTOMER;

-- remove files from internal stage as they are already loaded
REMOVE @CUSTOMER_STAGE;
