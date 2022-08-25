/*
Problem
-------------------------------------------------------------------------
show tables in a schema MySQL.

MetaDATA querying的命名是用snake convention的.
*/

# Solution 1:
# SHOW TABLE NAMES ONLY
-- SHOW 
-- TABLES;

# Solution 2:
# SHOW TALBL NAMES AND TYPES
-- SHOW FULL TABLES;

# Solution 3: textbook info
SELECT 
    table_name, table_type
FROM
    information_schema.tables
WHERE
    table_schema = 'EMPDEPT'