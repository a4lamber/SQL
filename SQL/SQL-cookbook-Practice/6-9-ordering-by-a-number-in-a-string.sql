/*
Problem
-------------------------------------------------------------------------
Order your result set in V4, based on the employee number.

Thought process
-------------------------------------------------------------------------
- sort by substring problem, 
- and employee could be converted from char to int for ordering


Solution
-------------------------------------------------------------------------
- Write a UDF to extract number substring
- REFEXP_SUBSTR() for MySQL 8+
*/


# Step1: Create a view
-- DROP VIEW IF EXISTS v4;

-- CREATE VIEW v4 AS 
-- SELECT CONCAT(e.ename,'   ',CAST(e.empno AS CHAR(4)),' ',d.dname) AS DATA
-- FROM emp e INNER JOIN dept d ON e.deptno = d.deptno;


