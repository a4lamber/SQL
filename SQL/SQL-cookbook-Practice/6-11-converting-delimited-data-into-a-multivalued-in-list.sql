/*
Problem
-------------------------------------------------------------------------
You have delimited data that you want to pass to the IN-list iterator of a WHERE
clause. Consider the following string:
'7654,7698,7782,7788'

You would like to use the string in a WHERE clause, but the following SQL fails
because EMPNO is a numeric column:
select ename,sal,deptno
from emp
where empno in ( '7654,7698,7782,7788' )

Find out way and make it work! 

思路 1 
-------------------------------------------------------------------------
- 将这个string decompose成四个string, 放在一行
- 将这四个string放入membership condition
- kappa (鲁棒性不够，因为可能有更多的comma-separated string).

思路 2 
-------------------------------------------------------------------------
- walk the string with pivot table,通过id in pivot table as iteror 来输出A,B,C,D
中由','分隔的东西
- 很巧妙，以前walk the string只是用来explode a string to character,但也可以来对付comma seperated group了

*/

# Solution 1: 
-- select 
-- 	substring_index(substring_index(a.tool,',',1),',',-1),
-- 	substring_index(substring_index(a.tool,',',2),',',-1),
-- 	substring_index(substring_index(a.tool,',',3),',',-1),
-- 	substring_index(substring_index(a.tool,',',4),',',-1)
-- from
-- (select '7654,7698,7782,7788' as tool from t1) as a #cross join (select id from t20) as b\



# Solution 2

select ename,sal,deptno
from emp
where empno in 
(
select 
	#substring_index(a.tool,',',b.id),
    substring_index(substring_index(a.tool,',',b.id),',',-1) as criteria#,
    #id
from 
	(select '7654,7698,7782,7788' as tool from t1) as a cross join (select id from t20) as b
# '7654,7698,7782,7788' - '7654769877827788' + 1 = 一共有四组数据
WHERE b.id <= (length(a.tool) - length(replace(a.tool,',','')) + 1)   
) 
    
    
    
    
    
    
    



