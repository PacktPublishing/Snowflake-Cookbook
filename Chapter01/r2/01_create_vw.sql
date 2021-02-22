USE ROLE SYSADMIN;

CREATE WAREHOUSE ETL_WH
WAREHOUSE_SIZE = XSMALL
MAX_CLUSTER_COUNT = 3
MIN_CLUSTER_COUNT = 1
SCALING_POLICY = ECONOMY
AUTO_SUSPEND = 300 -- suspend after 5 minutes (300 seconds) of inactivity
AUTO_RESUME = TRUE
INITIALLY_SUSPENDED = TRUE
COMMENT = 'Virtual Warehouse for ETL workloads. Auto scales between 1 and 3 clusters depending on the workload';
