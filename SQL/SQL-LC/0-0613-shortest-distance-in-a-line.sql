-- # Write your MySQL query statement below

-- # 这题很像algo题目，sorted后再search, 或者unsorted进行search;


SELECT
    MIN(ABS(a.x - b.x)) AS shortest
FROM
    Point AS a
INNER JOIN Point AS b
ON a.x != b.x

-- # Follow up: How could you optimize your query if the Point table is ordered in ascending order
-- # 排序之后优化也简单了
