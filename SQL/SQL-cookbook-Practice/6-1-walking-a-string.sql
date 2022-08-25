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
-- # 方式1: SELECT * FROM tableA, tableB (Ancient style of join, avoid at all cost)
-- # 方式2: select * from tableA CROSS JOIN tableB
-- SELECT 
-- 	ename, 
--     iter.id
-- FROM (SELECT ename FROM emp WHERE ename = 'KING') e 
-- CROSS JOIN (SELECT id FROM t10) AS iter



-- Step2: Add a filtering condition
-- SELECT
-- 	ename,
--     iter.id
-- FROM (SELECT ename FROM emp WHERE ename = 'KING') e 
-- CROSS JOIN (SELECT id FROM t10) AS iter
-- WHERE iter.id <= LENGTH(e.ename)


-- # StepFinal: use SUBSTR to walk
SELECT
    -- 动态的starting position, 相当于string中的index了
    SUBSTR(e.ename, iter.id, 1) AS walk
FROM
	-- 选择你想要的string with scalar subquery
    (SELECT ename FROM emp WHERE ename = 'KING') e CROSS JOIN
    -- 用pivot table t10的id column作为获取行数用来做itertor = 1,2,3,...10
    (SELECT id AS id FROM t10) AS iter
WHERE
    -- ename这个string的index, 只需要到LENGTH(e.enam)为止
    iter.id <= LENGTH(e.ename);