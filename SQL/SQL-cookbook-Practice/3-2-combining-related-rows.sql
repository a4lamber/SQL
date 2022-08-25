/*
Problem
-------------------------------------------------------------------------
You want to display the names of all employees in department
10 along with the location of each employee's department, but the data is in
two separate tables

知识点
-------------------------------------------------------------------------
- equi join的实现，是
    1.先做个cartesian product to find all possible combination satisfied e.deptno = 10
    2.再找到e.deptno = d.deptno 
- equi join实际上是早期ANSI style的join, 现如今都是用 JOIN clause了, avoid at all cost.
*/

# Solution 1: inner join where JOIN clause
-- SELECT 
--     e.ename, d.loc
-- FROM
--     emp e
--         INNER JOIN
--     dept d ON e.deptno = d.deptno
-- WHERE
--     e.deptno = 10

# Solution 2:equi-join (one type of inner join) with WHERE clause
SELECT 
    e.ename, d.loc
FROM
    emp e,
    dept d
WHERE
    e.deptno = 10 AND e.deptno = d.deptno

