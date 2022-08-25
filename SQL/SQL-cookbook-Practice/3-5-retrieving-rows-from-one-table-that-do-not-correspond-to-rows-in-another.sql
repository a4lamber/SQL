/*
Problem
-------------------------------------------------------------------------
You want to find rows that are in one table that do not have a match in another table.

知识点
-------------------------------------------------------------------------
- d.* for all accessing all column in aliased table d
- LEFT JOIN or LEFT OUTER JOIN
这其实就是我在3-4中的解法
*/

SELECT 
    d.*
FROM
    dept d
        LEFT OUTER JOIN
    emp e ON d.deptno = e.deptno
WHERE
    e.deptno IS NULL