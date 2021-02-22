--create a database where we will create the objects for this recipe. Within the database we will create a basic sequence object as shown below.
CREATE DATABASE C9_R6;
CREATE SEQUENCE SEQ1;

 
--select a value from this newly created sequence.
SELECT SEQ1.NEXTVAL;
 
--if we perform the same SELECT statement again, we will get the next value in the sequence, which in this case will be 2.
SELECT SEQ1.NEXTVAL;

 
--try executing several NEXTVAL in a single statement to validate that the function always returns unique values
SELECT SEQ1.NEXTVAL,SEQ1.NEXTVAL,SEQ1.NEXTVAL;
 
--create a sequence that starts at 777 (rather then 1) and increments by 100 (rather then 1). 
CREATE SEQUENCE SEQ_SPECIAL
START WITH =  777
INCREMENT BY = 100;
 
--test the preceding sequence
SELECT SEQ_SPECIAL.NEXTVAL,SEQ_SPECIAL.NEXTVAL,SEQ_SPECIAL.NEXTVAL;


--create a new table and insert data into one of its columns using a sequence.  
--Let us create the table first. 
CREATE TABLE T1 
(
  CUSTOMER_ID INTEGER,
  CUSTOMER_NAME STRING
);
-- create a sequence that will be used for populating auto-increment values in the CUSTOMER_ID column.
CREATE SEQUENCE T1_SEQ;

-- use the sequence in the INSERT INTO statement to populate data.
INSERT INTO T1
SELECT T1_SEQ.NEXTVAL,
        RANDSTR(10, RANDOM())
FROM
  TABLE
    (generator(rowcount => 500));

SELECT * FROM T1;
 
--define the default value for a table column to be the sequence next value.
CREATE SEQUENCE T2_SEQ;
CREATE TABLE T2 
(
  CUSTOMER_ID INTEGER DEFAULT T2_SEQ.NEXTVAL,
  CUSTOMER_NAME STRING
);

--insert data into this table but omit the CUSTOMER_ID while inserting
INSERT INTO T2 (CUSTOMER_NAME)
SELECT RANDSTR(10, RANDOM())
FROM
  TABLE
    (generator(rowcount => 500));

--check the data in the table
SELECT * FROM T2;