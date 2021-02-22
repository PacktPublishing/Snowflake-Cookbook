--start by creating a database, in which we will create our JavaScript based scalar UDFs.
CREATE DATABASE C10_R3;

--create a very simple UDF that squares the value that is provided as the input. we must capitalize the parameter name when used in the function definition. This can be seen in the code below, where the input parameter val was used in the uppercase and used as VAL.
CREATE FUNCTION square(val float)
RETURNS float
LANGUAGE JAVASCRIPT  
AS
  'return VAL * VAL;'
;

--test this function by calling it in a SELECT statement
SELECT square(5);
--The statement will output the value 25 as expected. 

--create a recursive JavaScript UDF. We will be creating a simple factorial function which will recursively call itself to calculate factorial of the input value.
CREATE FUNCTION factorial(val float)
RETURNS float
LANGUAGE JAVASCRIPT  
AS
$$
    if ( VAL == 1 ){
        return VAL;
    }
    else{
        return VAL * factorial(VAL -1);
    }
$$
;

--try out the factorial function by invoking the function in a select statement, as shown as follows.
SELECT factorial(5);
