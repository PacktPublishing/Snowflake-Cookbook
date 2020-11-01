USE C7_R3;
-- creation of another table which will hold the customer address data.
CREATE TABLE CUSTOMER_ADDRESS
(
  CUST_ID NUMBER,
  CUST_ADDRESS STRING
);

-- Optionally if you like you can populate this table with a thousand rows of dummy data 
INSERT INTO CUSTOMER_ADDRESS
SELECT
    SEQ8() AS CUST_ID,
	RANDSTR(50,RANDOM()) AS CUST_ADDRESS
FROM TABLE(GENERATOR(ROWCOUNT => 1000));

-- describe the share to see what is contained in the share
DESC SHARE share_cust_database;

-- redo grant select on ALL tables that exist in the database's pubic schema
-- to accomodate the newly created table
-- you can run the below command in a Task on a schedule to ensure
-- any new objects added in the shared database are automatically granted to the share object
GRANT SELECT ON ALL TABLES IN SCHEMA C7_R3.public TO SHARE share_cust_database;


--Let us again check if the new table is now added to the share. 
DESC SHARE share_cust_database;
