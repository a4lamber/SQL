/*
Problem
-------------------------------------------------------------------------
如果需要sort的那一列，存在null, 那么如何控制null比non-null先出现还是后出现呢？

分析
-------------------------------------------------------------------------
用subquery和CASE clause创造出一个工具人列 of 0s and 1s.
由此可以通过额外sort这个工具人列，来控制:
- null是出现在non-null前还是后;

如果工具人列满足，null则0, non-null则1的话,
non-null values first then null 则有两种情况:
- ORDER BY toolman desc, comm desc
- ORDER BY toolman desc, comm asc
null first then non-null 则有两种情况
- ORDER BY toolman asc, comm desc
- ORDER BY toolman asc, comm asc

总计四种情况.
*/
SELECT 
    ename, sal, comm
FROM
-- 创建一个subquery
    (SELECT 
        ename,
		sal,
		comm,
-- 用case clause创造出一个工具人column
		CASE
			WHEN comm IS NULL THEN 0
			ELSE 1
		END AS toolman
    FROM
        emp) AS dummy
ORDER BY toolman DESC,comm ASC