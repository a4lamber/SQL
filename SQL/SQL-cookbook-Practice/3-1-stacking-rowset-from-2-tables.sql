/*
Problem
-------------------------------------------------------------------------
display the name and department# in department#10
from table EMP on top of the name and department# from table DEPT

Note
-------------------------------------------------------------------------
- UNION ALL and UNION, UNION would remove duplicates while UNION ALL won't.
- Use PIVOTTTTTT table as a toolman table for 
	- creating line separator
    - prob pivot later on? idk yet. 
*/
SELECT 
    ename as "ename and dname", deptno
FROM
    emp
WHERE
    deptno = 10 
UNION ALL 
-- Using pivot table for creating a separator
SELECT '------------',NULL FROM t1
UNION ALL
SELECT 
    dname, deptno
FROM
    dept;


