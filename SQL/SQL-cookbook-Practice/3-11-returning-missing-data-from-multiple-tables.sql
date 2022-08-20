/*
应用场景: Return missing data from multiple tables simultaneously.
Problem: Returning rows
from table DEPT that do not exist in table EMP (any departments that have no
employees) requires an outer join. Consider the following query, which returns all
DEPTNOs and DNAMEs from DEPT along with the names of all the employees in
each department (if there is an employee in a particular department)
*/

select d.deptno,d.dname,e.ename from dept d
left outer join emp e on d.deptno = e.deptno
where e.ename is NULL 