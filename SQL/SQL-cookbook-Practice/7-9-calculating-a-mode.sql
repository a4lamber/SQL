/*
Problem
-------------------------------------------------------------------------
find the mode of the salaies in DEPTNO 20.

知识点
-------------------------------------------------------------------------
- mode: mode in math is the element that appears most frequently for
a given set of data
- DENSE_RANK(): window function that assigns a rank to each row within
a partition or result set with no gaps in ranking values.

Reference
-------------------------------------------------------------------------
https://www.begtut.com/mysql/mysql-dense_rank-function.html
*/

select sal,
	   dense_rank()over(order by cnt desc) as rnk
from (
select sal,
	   count(*) as cnt
from emp
where deptno = 20
group by sal
) x