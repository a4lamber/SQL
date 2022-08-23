/*
Problem
-------------------------------------------------------------------------
Find the total number of employees as well as the employees in each department

Note
-------------------------------------------------------------------------
count() ignores null rows except when count(*)
*/


# count total number of employees
-- select 
-- 	count(empno) total_emp
-- from emp


# count number of employee in each department
select 
	deptno,
	count(empno) as dept_num_emp 
from emp
group by deptno
order by deptno