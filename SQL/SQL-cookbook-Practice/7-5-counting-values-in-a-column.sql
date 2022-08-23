/*
Problem
-------------------------------------------------------------------------
Find out how many employees are on commission (# of non-NULL values in comm column).

*/
select 
	empno,
    comm,
    count(comm)
from emp