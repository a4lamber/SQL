/*
Problem
-------------------------------------------------------------------------
Order your result set based on a substring.
*/

select ename, substring(ename,-2) last2 from emp
order by substring(ename,-2)