/*
Problem: return all employees in EMP whose commission is less than
the comission of employee WARD. Employee with a NULL commission should 
be included as well
*/
select ename,is_less_ward
from
(
select empno,
	   ename,
       coalesce(comm,0),
	   CASE 
			WHEN coalesce(comm,0) < (select comm from emp where ename = 'WARD') then 1
            else 0
		END as is_less_ward
from emp) as dummy
where is_less_ward = 1
