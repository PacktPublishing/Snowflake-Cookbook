--login as user_operations1 user and validate the default role for the user.
SELECT CURRENT_ROLE();
 
--try creating a new user using the user_operations1 user.
CREATE USER new_analyst1 PASSWORD='password123' MUST_CHANGE_PASSWORD = TRUE;
 
--create a new role using the user_operations1 user.
CREATE ROLE BA_ROLE;
 
--grant the BA_ROLE to the new_analyst1 created previously and will also set it as the default role for the new_analyst1.
GRANT ROLE BA_ROLE TO USER new_analyst1;
ALTER USER new_analyst1 SET DEFAULT_ROLE = BA_ROLE;
 
--try and grant the BA_ROLE some privileges. Since we are performing this action as a USERADMIN, the command should fail as the USERADMIN is not allowed to manage privileges. 
GRANT USAGE ON DATABASE test_database TO ROLE BA_ROLE;
