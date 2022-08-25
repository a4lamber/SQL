/*
Problem
-------------------------------------------------------------------------
compute running product on a numeric column.


思路
-------------------------------------------------------------------------
- 见markdown for details.
*/

SELECT 
	empno,
    sal,
    EXP(SUM(ln(sal)) OVER (ORDER BY sal,empno)) AS running_product
FROM emp
