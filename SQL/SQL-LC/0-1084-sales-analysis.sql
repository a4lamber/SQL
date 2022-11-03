# Write your MySQL query statement below

/*
Tricky part is to count sale only in spring of 2019
*/

# Solution 1:
# WITH CTE AS
# (
# SELECT
#     a.product_id,
#     b.product_name,
#     a.sale_date
# FROM
#     Sales AS a
# LEFT JOIN Product AS b
# ON a.product_id = b.product_id
# ),
# spring_2019 AS
# (
# SELECT
#     *
# FROM
#     CTE
# WHERE sale_date BETWEEN '2019-01-01' AND '2019-03-31'
# ),
# other_time_domain AS
# (
# SELECT
#     *
# FROM
#     CTE
# WHERE sale_date < '2019-01-01' OR sale_date >'2019-03-31'
# )
# SELECT DISTINCT
#     a.product_id,
#     a.product_name
# FROM
#     spring_2019 AS a
# LEFT JOIN other_time_domain AS b
# ON a.product_id = b.product_id
# WHERE b.product_id IS NULL;


# Solution 2: from discussion forum
SELECT 
    s.product_id,
    p.product_name
FROM Sales AS s
LEFT JOIN Product AS p
ON s.product_id = p.product_id
GROUP BY s.product_id
HAVING MIN(sale_date) >= CAST('2019-01-01' AS DATE) AND
       MAX(sale_date) <= CAST('2019-03-31' AS DATE)

# Comment 2: solution 2 is slower than solution 1 but solution 1 requires CTE 
which
# takes space. exchange space for speed.
