/*
Problem
-------------------------------------------------------------------------
You want to find common rows between two tables, but there are
multiple columns on which you can join.
1. SQL Table和VIEW之间，找相同行
*/

# Create a view (like filter VIEW in excel)

-- CREATE VIEW v1 AS
--     SELECT 
--         ename, job, sal
--     FROM
--         emp
--     WHERE
--         job = 'CLERK'

# Solution 1: equi-join ancient style bro
-- SELECT 
--     e.empno, e.ename, e.job, e.sal, e.deptno
-- FROM
--     emp e,
--     v1
-- WHERE
--     e.ename = v1.ename 
-- AND e.job = v1.job
-- AND e.sal = v1.sal

# Solution 2: join clause
SELECT
	e.empno, 
	e.ename, 
	e.job,
	e.sal,
	e.deptno
FROM
	emp e inner join v1 
on (
	e.ename = v1.ename 
and e.job = v1.job
and e.sal = v1.sal);

