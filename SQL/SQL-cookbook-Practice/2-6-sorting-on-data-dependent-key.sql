/*
Problem
-------------------------------------------------------------------------
You want to sort by comm if job is 'salesman'
otherwise you sort by sal. 
也蛮make sense的，销售用提成排序，其他人用salary排序

Solution
-------------------------------------------------------------------------
- subquery with a 工具人 column created by CASE
- ORDER BY 联名 CASE
*/
SELECT 
    ename, 
    sal as salary, 
    job, 
    comm as commission
FROM
    (SELECT 
        ename,
		sal,
		job,
		comm,
		CASE
			WHEN job = 'SALESMAN' THEN 1
			ELSE 0
		END AS is_salesman
    FROM
        emp) AS dummy
ORDER BY CASE
    WHEN is_salesman = 1 THEN comm
    ELSE sal
END