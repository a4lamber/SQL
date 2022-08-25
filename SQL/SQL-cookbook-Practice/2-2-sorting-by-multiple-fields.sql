/*
Problem
-------------------------------------------------------------------------
sort rows from EMP table first by deptno ascending,
then by salary descending.

Discussion
-------------------------------------------------------------------------
- Order of precedence in ORDER BY is from left to right
- it's okay to sort by columns not specified in select statement.
But it's not true when you using GROUP BY or DISTINCE.
- field is a term equivalent to column in SQL. (微信读书看到的)

*/
SELECT 
    *
FROM
    emp
ORDER BY deptno ASC, sal DESC