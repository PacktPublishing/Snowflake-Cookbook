
val SNOWFLAKE_SOURCE_NAME = "net.snowflake.spark.snowflake"

// initialise the connectivity related variables
//Please make sure that you replace the placeholders in the following code with the information pertaining to your account.
var snowflakeOptions = Map(
    "sfURL" -> "<replace_with_your_account_url>",
    "sfUser" -> "<replace_with_a_user_name>",
    "sfPassword" -> "<replace_with_password>",
    "sfDatabase" -> "SNOWFLAKE_SAMPLE_DATA",
    "sfSchema" -> "TPCH_SF1",
    "sfWarehouse" -> "<replace_with_the_virtual_warehouse>"
)

//read and output a table
spark.read
    .format(SNOWFLAKE_SOURCE_NAME)
    .options(snowflakeOptions)
    .option("dbtable", "REGION")
    .load().show()