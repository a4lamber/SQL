/*
Problem
-------------------------------------------------------------------------

You want to traverse a string to return each character as a row,
but SQL lacks a loop operation. For example, you want to display
the ENAME 'king' from table EMP as four rows, where each row 
contains just characters from king.

Walking a string: mimic a loop to traverse a string
since there is limited loop functionality in SQL.

Note
-------------------------------------------------------------------------
- SQL做string parsing确实比较cumbersome, 由于没有loop的原因
- walking a string with pivot table是loop的平替
- cardinality stands for how many rows in a table for simplicity.
*/


-- # Step 1:cartesian product 有两种表达方式 
-- # 方式1: SELECT * FROM tableA, tableB
-- # 方式2: select * from tableA CROSS JOIN tableB
-- select ename, iter.id
-- from (select ename from emp where ename = 'KING') e cross join (select id from t10) iter



# Step2: Add a filtering condition
-- select ename, iter.id
-- from (select ename from emp where ename = 'KING') e cross join (select id from t10) iter
-- where iter.id <= length(e.ename)


-- # StepFinal: use SUBSTR to walk
SELECT 
    SUBSTR(e.ename, iter.id, 1) AS walk
FROM
	# 选择你想要的string
    (SELECT ename FROM emp WHERE ename = 'KING') e,
    # 用pivot table获取行数用来做itertor = 1,2,3,...10
    (SELECT id AS id FROM t10) iter
WHERE
    iter.id <= LENGTH(e.ename)