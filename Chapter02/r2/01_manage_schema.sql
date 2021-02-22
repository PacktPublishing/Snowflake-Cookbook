CREATE DATABASE testing_schema_creation;

SHOW SCHEMAS IN DATABASE testing_schema_creation;

CREATE SCHEMA a_custom_schema
COMMENT = 'A new custom schema';

SHOW SCHEMAS LIKE 'a_custom_schema' IN DATABASE testing_schema_creation ;

CREATE TRANSIENT SCHEMA temporary_data 
DATA_RETENTION_TIME_IN_DAYS = 0
COMMENT = 'Schema containing temporary data used by ETL processes';

SHOW SCHEMAS LIKE 'temporary_data' IN DATABASE testing_schema_creation ;
