/*
Problem
-------------------------------------------------------------------------
Count the number of times a character or substring
occurs within a given string.
*/

# Solution 1 (My solution, using string walk):  
-- SELECT 
-- 	hello,
--     COUNT(*) num_of_comma
-- FROM
-- (SELECT 
-- 	SUBSTR(e.comment,d.id,1) AS hello,
--     d.id
-- FROM
-- 	(select '10,CLARK,MANAGER' AS COMMENT FROM t1) e 
-- CROSS JOIN (SELECT id FROM t20) AS d
-- WHERE id <= length(e.comment)) AS dummy
-- GROUP BY hello
-- HAVING hello = ',';

-- Solution 2 optimal solution:
-- 将string中你想要的search的character变为null,再计算俩string的长度差即可
-- 如果想搜索有多少次substring出现，只需要

SELECT
	(LENGTH('10,CLARK,MANAGER') - LENGTH(REPLACE('10,CLARK,MANAGER',',',''))) AS num_of_comma 


