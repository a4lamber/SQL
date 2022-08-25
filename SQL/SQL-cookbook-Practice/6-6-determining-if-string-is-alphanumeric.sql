/*
Problem
-------------------------------------------------------------------------
Omit rows containing data other than letters and digits (alphanumeric).

思路
-------------------------------------------------------------------------
- 找到所有non-alphanumeric char并把这些剔除
- 找到所有alphanumeric char并把这些提取

知识点
-------------------------------------------------------------------------
CAST(): Converting a value from one datatype to another specific datatype.
CAST() is kinda general, for more specific
- DATE()
- DATETIME()
- TIME()
- CHAR()
- SIGNED()
- UNSIGNED()
- BINARY()
*/

-- # clear previous view v3 just in case. (和Matlab script之前clc;clear;一样)
-- drop view if exists v3;

-- # create view v3
-- CREATE VIEW v3 AS
-- 	# deptno 10的名字
--     SELECT 
--         ename AS data
--     FROM
--         emp
--     WHERE
--         deptno = 10
-- 	# deptno 20的(名字+符号+薪资)
--     UNION ALL SELECT 
--         CONCAT(ename,
--                 ', $',
--                 CAST(sal AS CHAR (4)),
--                 '.00') AS data
--     FROM
--         emp
--     WHERE
--         deptno = 20
-- 	# deptno 30的(名字 + 部门号)
--     UNION ALL SELECT 
--         CONCAT(ename, CAST(deptno AS CHAR (4))) AS data
--     FROM
--         emp
--     WHERE
--         deptno = 30

-- Solution: 
SELECT 
DATA 
FROM v3
WHERE DATA regexp '[^0-9a-zA-Z]' = 0
/*
符号^: stands for negation
'[^0-9a-zA-Z]' 判断是否不是alphanumeric
那么 return 0 这个char不符合正则判据，那么是alphanumeric
	 return 1 这个char符合正则判据，那么non-alphanumeric
那么
where data regexp '[^0-9a-zA-Z]' = 0 代表着，filter data column where `[^0-9a-zA-Z]` = 0 , 
double-negation for positivity.
*/
