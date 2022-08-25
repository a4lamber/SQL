/*
Problem
-------------------------------------------------------------------------
Want to find the average salary for all employees as well as the average salary for each department.

思路
-------------------------------------------------------------------------
For average salary in a department,
- group by department number
- use aggregate fcn
For average salary in a department,
- select avg(sal) from emp

Note
-------------------------------------------------------------------------
- AVG(functions) ignores NULLs. It's safer to use along alide with COALESCE()
*/

-- SET sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));

-- Solution: get average salary for all employees
-- select avg(sal) from emp

-- Solution: get average salary for each department

SELECT  
        deptno,
        GROUP_CONCAT(ename ORDER BY ename SEPARATOR ',') AS NAMES,
        GROUP_CONCAT(sal SEPARATOR ',') AS sals,
        AVG(sal) AS dept_sal_avg
FROM emp
GROUP BY deptno