/*
Problem
-------------------------------------------------------------------------
You want to know whether two tables or views have the same data (Cardinality and values).

应用场景有些少,很少来比较俩table有什么不同和相同，只是单纯的向数据库提款, 所以略
*/

/*
创造一个VIEW v2, 和emp table的差别是:
- 多了一行重复的信息
- 少了几行deptno等于10的员工的信息
*/ 
-- CREATE VIEW v2
-- AS
-- SELECT * FROM emp where deptno != 10
-- union all
-- select * from emp where ename = 'WARD';



