--Logout from the dev_dba_user1  and log back in as the user used previous steps. We now will create a new role to manage access to the DEV database, hence the name DEV_DBA. 
USE ROLE SECURITYADMIN;
CREATE ROLE DEV_DBA;
 
--a new role has no privileges after creation, which we can validate by the following SQL. 
SHOW GRANTS TO ROLE DEV_DBA;

--provide the new role some privileges on the DEV database. 
GRANT ALL ON DATABASE DEV TO ROLE DEV_DBA;
GRANT ALL ON ALL SCHEMAS IN DATABASE DEV TO ROLE DEV_DBA;
GRANT ALL ON TABLE DEV.PUBLIC.CUSTOMER TO ROLE DEV_DBA;
SHOW GRANTS TO ROLE DEV_DBA;
 
--grant the DEV_DBA role to dev_dba_user1. 
USE ROLE SECURITYADMIN;
GRANT ROLE DEV_DBA TO USER dev_dba_user1;