--Let us now login as the hr_user1 and see if we can access the salary data.
USE ROLE HR_ROLE;
SELECT * FROM sensitive_data.PUBLIC.SALARY;