--start by creating a database, in which we will create our SQL tabular UDFs.
CREATE DATABASE C10_R4;
USE DATABASE C10_R4;
USE SCHEMA PUBLIC;

--run an out of the box table function provided by Snowflake to see how to call table functions and review the results returned by that function. The function that we are going to use is used for generating rows of random data and is a handy function for various scenario. The function is aptly called GENERATOR. Let us call this function to generate 10 rows of data. To do so run the command below.
SELECT seq4() AS incremental_id, random() AS a_random_number
FROM TABLE(generator(rowcount => 10));

--create a quite simple table function using JavaScript. The function will return the 2 letter ISO code for a country. To keep things simple, we will use hard coded values for this initial example.  Run the following SQL to create this function.
CREATE FUNCTION CountryISO()
RETURNS TABLE(CountryCode String, CountryName String)
LANGUAGE JAVASCRIPT
AS
$$
   {
   processRow: function f(row, rowWriter, context){
       rowWriter.writeRow({COUNTRYCODE: "AU",COUNTRYNAME: "Australia"});
       rowWriter.writeRow({COUNTRYCODE: "NZ",COUNTRYNAME: "New Zealand"});   
       rowWriter.writeRow({COUNTRYCODE: "PK",COUNTRYNAME: "Pakistan"});   
       }
    }    
$$;

--call this function.
SELECT * FROM TABLE(CountryISO());

--you can treat this output as any other relational table, so you can add where clauses and select only particular columns.
SELECT COUNTRYCODE FROM TABLE(CountryISO()) WHERE CountryCode = 'PK';

--We do not have to hardcode values in a table function but rather we can select data from existing table and process on each row. Let’s create such a java script-based table function which processes on values for each row of a table produces the count of character for the input.
CREATE FUNCTION StringSize(input String)
RETURNS TABLE (Size FLOAT)
LANGUAGE JAVASCRIPT
AS 
$$
{
    processRow: function f(row, rowWriter, context) {
      rowWriter.writeRow({SIZE: row.INPUT.length});
    }
}
$$;

--call this function to review the output. Now, we can call this function for a single value but that is not very useful, however, let’s call for a single value to demonstrate the concept.
SELECT * FROM TABLE(StringSize('TEST'));

--you can join this newly created table function with another table and have the table function process multiple rows. 
SELECT * FROM 
SNOWFLAKE_SAMPLE_DATA.TPCH_SF1.NATION, TABLE(StringSize(N_NAME));
