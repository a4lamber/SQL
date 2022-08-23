/*
Problem
-------------------------------------------------------------------------
compute running product on a numeric column.


思路
-------------------------------------------------------------------------
- 见markdown for details.
*/

select 
	empno,
    sal,
    exp(sum(ln(sal)) over (order by sal,empno)) as running_product
from emp
