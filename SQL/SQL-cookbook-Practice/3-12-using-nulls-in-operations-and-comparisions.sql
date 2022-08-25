/*
Problem
-------------------------------------------------------------------------
return all employees in EMP whose commission is less than
the comission of employee WARD. Employee with a NULL commission should 
be included as well
*/
SELECT 
	ename,
	is_less_ward
FROM
(
SELECT 
	empno,
	ename,
    COALESCE(comm,0),
	CASE 
		-- 比较每个人的commission with ward's commission (scalar subquery)
		WHEN COALESCE(comm,0) < (SELECT comm FROM emp WHERE ename = 'WARD') THEN 1
        ELSE 0
	END AS is_less_ward
FROM emp) AS dummy
WHERE is_less_ward = 1
