USE ROLE SYSADMIN;

CREATE DATABASE our_first_database
COMMENT = 'Our first database';

SHOW DATABASES LIKE 'our_first_database';

CREATE DATABASE production_database 
DATA_RETENTION_TIME_IN_DAYS = 15
COMMENT = 'Critical production database';

SHOW DATABASES LIKE 'production_database';


CREATE TRANSIENT DATABASE temporary_database 
DATA_RETENTION_TIME_IN_DAYS = 0
COMMENT = 'Temporary database for ETL processing';

SHOW DATABASES LIKE 'temporary_database';

ALTER DATABASE temporary_database
SET DATA_RETENTION_TIME_IN_DAYS = 1;

SHOW DATABASES LIKE 'temporary_database';
