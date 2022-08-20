/*
应用场景: You wish to find those values in one table (source table),
that do not also exist in some target table.
Problem: You want to find which departments (if any) in the table
DEPT do not exist in the table EMP.
*/

# Solution 1: 我的解法 left join with where
-- SELECT 
--     d.deptno, d.dname, d.loc,e.ename
-- FROM
--     dept d
--         LEFT JOIN
--     emp e ON d.deptno = e.deptno
-- where e.deptno IS NULL

# Solution 2: subquery as a condition with IN keyword
SELECT 
    deptno
FROM
    dept
WHERE
    deptno NOT IN (SELECT 
            deptno
        FROM
            emp)