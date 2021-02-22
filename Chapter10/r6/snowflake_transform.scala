import org.apache.spark.sql.DataFrameReader
import org.apache.spark.sql.DataFrame
import org.apache.spark.sql.SaveMode

val SNOWFLAKE_SOURCE_NAME = "net.snowflake.spark.snowflake"

// initialise the connectivity related variables
//Please make sure that you replace the placeholders in the code below with the information pertaining to your account.
var snowflakeOptions = Map(
    "sfURL" -> "<replace_with_your_account_url>",
    "sfUser" -> "<replace_with_a_user_name>",
    "sfPassword" -> "<replace_with_password>",
    "sfDatabase" -> "NEW_DB",
    "sfSchema" -> "PUBLIC",
    "sfWarehouse" -> "<replace_with_the_virtual_warehouse>"
)

// validate that connectivity works by querying a sample table
//read and output a table
spark.read
    .format(SNOWFLAKE_SOURCE_NAME)
    .options(snowflakeOptions)
    .option("dbtable", "SNOWFLAKE_SAMPLE_DATA.TPCH_SF1.REGION")
    .load().show()


val aggDFReader:DataFrameReader = spark.read
    .format("net.snowflake.spark.snowflake")
    .options(snowflakeOptions)
    .option("query", """SELECT C.C_MKTSEGMENT AS MARKET_SEGMENT, SUM(O_TOTALPRICE) AS REVENUE 
						FROM SNOWFLAKE_SAMPLE_DATA.TPCH_SF1.ORDERS O 
						LEFT OUTER JOIN SNOWFLAKE_SAMPLE_DATA.TPCH_SF1.CUSTOMER C 
						ON O.O_CUSTKEY = C.C_CUSTKEY 
						GROUP BY C.C_MKTSEGMENT;""")   

val aggDF: DataFrame = aggDFReader.load()	
aggDF.show()

aggDF.write
    .format("snowflake")
    .options(snowflakeOptions)
    .option("dbtable", "CUST_REV")
    .mode(SaveMode.Overwrite)
    .save()