/*
Problem
-------------------------------------------------------------------------
return name, salary and status from emp table. status is defined as
if salary <= 2000, status = 'UNDERPAID'
elif salary >= 4000, status = 'OVERPAID'
else status = 'OK';

Note
-------------------------------------------------------------------------
Conditional logic in a SELECT statement,
1. CASE clause in select as an column
2. if comment out ELSE 'OK', its value would be NULL
*/
SELECT 
    ename,
    sal,
    CASE
        WHEN sal <= 2000 THEN 'UNDERPAID'
        WHEN sal >= 4000 THEN 'OVERPAID'
        ELSE 'OK'
    END AS status
FROM
    emp
