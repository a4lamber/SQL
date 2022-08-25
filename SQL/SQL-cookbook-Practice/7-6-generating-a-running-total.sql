/*
Problem
-------------------------------------------------------------------------
calculate a running total of salary for all employees


知识点
-------------------------------------------------------------------------
- a running total is the culmulative sum of a value and all previous values
in the column.
- window functions with OVER clause
- window function for running total need to order by both interested column and primary key
Reference
-------------------------------------------------------------------------
https://learnsql.com/blog/running-total-sql/
*/

select 
	ename,
    empno,
    sal,
    -- include EMPNO (primary key) to avoid duplicate values
    sum(sal) over (order by sal,empno) as running_total_sal,
    -- 不加primary key (规避由于sal相同，导致的加两次ward.sal = marthin.sal, scott.sal = ford.sal)
    sum(sal) over (order by sal) as running_total_wrong
from emp
order by sal
