/*
Problem
-------------------------------------------------------------------------
Order your result set based on a substring.
*/

SELECT 
    ename, 
    SUBSTRING(ename,-2) last2 
FROM emp
ORDER by SUBSTRING(ename,-2)