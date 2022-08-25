/*
Note
-------------------------------------------------------------------------
Inn different DBMS, different syntax for 
string concatenation is used.

MySQL:
see code

SQL Server:
select ename + ' WORKS AS A ' + job

DB2, Oracle, PostgreSQL:
select ename || ' WORKS AS A ' || job
*/
SELECT 
    CONCAT(ename, ' WORKS AS A ', job) as msg
FROM
    emp
WHERE
    deptno = 10