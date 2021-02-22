--create a database called CHAPTER9.
CREATE DATABASE CHAPTER9;
USE CHAPTER9;
--create two tables to use in this recipe. One table is supposed to store debit in an account and the other one shall store credits. The tables will be updated/inserted in a transaction. 
CREATE TABLE c9r4_credit (
account int
,amount int
,payment_ts timestamp
);

CREATE TABLE c9r4_debit (
account int
,amount int
,payment_ts timestamp
);



-- create a stored procedure that will be used in a transaction. To explain different scenarios, we have introduced a random error in the stored procedure by using a random number. If that error is hit, the query statement is not executed, and the stored procedure executes a roll back. 
create or replace procedure sp_adjust_credit ()
    returns string
    language javascript
    as
    $$
    
    var sql_command = "";
    if ((Math.floor(Math.random() + 0.5) == 0)){
        sql_command = "insert into CHAPTER9.PUBLIC.C9R4_CREDIT select * from CHAPTER9.PUBLIC.C9R4_DEBIT where CHAPTER9.PUBLIC.C9R4_DEBIT.payment_ts > (select IFF(max(payment_ts) IS NULL,to_date('1970-01-01'),max(payment_ts)) from CHAPTER9.PUBLIC.C9R4_CREDIT)";
    }else{
        snowflake.execute (
            {sqlText: "rollback"}
        );
        return "Failed randomly";   // Return a success/error indicator.
    }
        
    try {
        snowflake.execute (
            {sqlText: sql_command}
            );
        return "Succeeded.";   // Return a success/error indicator.
        }
    catch (err)  {
        
        snowflake.execute (
            {sqlText: "rollback"}
        );
        return "Failed: " + err;   // Return a success/error indicator.
        }
    $$;

--use the above stored procedure sp_adjust_credit() within a transaction, preceded by an INSERT into the C9R4_CREDIT.  
begin transaction;
insert into c9r4_debit values (1,100,current_timestamp());
call sp_adjust_credit();
commit;
 

--repeat the above process, but with account column set to 2 this time.
begin transaction;
insert into c9r4_debit values (2,100,current_timestamp());
--call the procedure and follow that by a commit.
call sp_adjust_credit();
commit;