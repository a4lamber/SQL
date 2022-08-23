/*
Problem
-------------------------------------------------------------------------
Compute the sum of all values, such as all employee salaries in a column.
*/


select 
	deptno,
	sum(sal)
from emp
group by deptno
order by deptno