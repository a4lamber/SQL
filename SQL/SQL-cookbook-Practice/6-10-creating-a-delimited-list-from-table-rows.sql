/*
Problem
-------------------------------------------------------------------------
concatenate all strings in a group with arbitary delimiter as a new string

知识点
-------------------------------------------------------------------------
- GROUP_CONCAT(expression spearator '.'): 将group中所有字符串串起来.

https://www.w3resource.com/mysql/aggregate-functions-and-grouping/aggregate-functions-and-grouping-group_concat.php
*/

-- SET sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));

select deptno,ename,count(*), GROUP_CONCAT(ename SEPARATOR ',')from emp
group by deptno