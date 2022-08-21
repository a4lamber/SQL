/*
Problem: list all columns in a table

在python pandas的DataFrame object,可以用以下method来access
df.columns()

知识点:
- INFORMATION_SCHEMA provides access to database matadata, information about 
the MySQL server such as the name of a database or table, the data type
of a column, or access privileges. Other terms that are sometimes
used for this information are data dictionary and system catalog.
*/
-- SHOW SCHEMAS

SELECT 
    column_name, data_type, ordinal_position
FROM
    information_schema.columns
WHERE
    table_name = 'dept'
        AND table_schema = 'EMPDEPT'