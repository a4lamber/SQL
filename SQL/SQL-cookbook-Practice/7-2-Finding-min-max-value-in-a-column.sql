/*
Problem
-------------------------------------------------------------------------
find highest and lowest salary for all employees;
find highest and lowest salary in each department
*/


# Solution
-- select 
-- 		max(sal) as maxsal,
--         MIN(sal) as minsal
-- from emp

# Solution
select
	deptno,
	max(sal) as dept_maxsal,
    min(sal) as dept_minsal
from emp
group by deptno
order by deptno
    