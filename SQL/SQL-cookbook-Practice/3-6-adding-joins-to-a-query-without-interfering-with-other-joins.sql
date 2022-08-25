/*
Problem
-------------------------------------------------------------------------
Return all employees, the location of the department in which they work and the
date they received a bonus.

Discussion
-------------------------------------------------------------------------
需要的信息有
- all employees info from emp table
- location of department from dept table
- date they received a bonus emp_bonus table
*/

# Solution 1: three table join
SELECT 
    e.empno, 
    e.ename,
    d.loc, 
    eb.received
FROM
    emp e
        INNER JOIN
    dept d ON e.deptno = d.deptno
        LEFT OUTER JOIN
    emp_bonus eb ON e.empno = eb.empno
ORDER BY e.empno


