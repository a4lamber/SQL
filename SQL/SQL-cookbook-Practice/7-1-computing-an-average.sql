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

# Solution: get average salary for all employees
# select avg(sal) from emp

# Solution: get average salary for each department
select  
        deptno,
        group_concat(ename order by ename separator ',') as names,
        group_concat(sal separator ',') as sals,
        avg(sal) as dept_sal_avg
from 	emp
group by deptno