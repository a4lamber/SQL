/*
应用场景
-------------------------------------------------------------------------
Return missing data from multiple tables simultaneously.

Problem
-------------------------------------------------------------------------
Returning rows from table DEPT that do not exist in table EMP (any departments that have no
employees) requires an outer join. Consider the following query, which returns all
DEPTNOs and DNAMEs from DEPT along with the names of all the employees in
each department (if there is an employee in a particular department)
*/

SELECT 
    d.deptno,
    d.dname,
    e.ename 
FROM dept d
    LEFT OUTER JOIN 
emp e ON d.deptno = e.deptno
WHERE e.ename IS NULL 
