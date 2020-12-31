--convert a number stored as a string to a numeric value.
SELECT '100.2' AS input, 
        TO_NUMBER(input),  
        TO_NUMBER(input, 12, 2);
		
--TO_NUMBER function works great, until it encounters a non-numeric value. 
SELECT 'not a number' AS input, 
        TO_NUMBER(input);

 
--use one of the TRY_ function on a non-numeric input, so it fails gracefully
SELECT 'not a number' AS input, 
        TRY_TO_NUMBER(input);

 
--perform the type conversion as per normal when a proper numeric input is provided.
SELECT '100.2' AS input, 
        TRY_TO_NUMBER(input);

 
--conversion of string values into Boolean data type. 
--the following query string values True, true, tRue, T, yes, on and 1 are considered to be boolean value TRUE
SELECT  TO_BOOLEAN('True'),
        TO_BOOLEAN('true'),
        TO_BOOLEAN('tRuE'),
        TO_BOOLEAN('T'),
        TO_BOOLEAN('yes'),
        TO_BOOLEAN('on'),
        TO_BOOLEAN('1');

 
--Conversely string values False, false, FalsE, f, no, off and 0 all convert into FALSE.
SELECT  TO_BOOLEAN('False'),
        TO_BOOLEAN('false'),
        TO_BOOLEAN('FalsE'),
        TO_BOOLEAN('f'),
        TO_BOOLEAN('no'),
        TO_BOOLEAN('off'),
        TO_BOOLEAN('0');
 
--convert a string value that contains a date.
SELECT TO_DATE('2020-08-15'), 
        DATE('2020-08-15'), 
        TO_DATE('15/08/2020','DD/MM/YYYY');

 
--try and convert to a timestamp. 
SELECT TO_TIMESTAMP_NTZ ('2020-08-15'), 
        TO_TIMESTAMP_NTZ ('2020-08-15 14:30:50');