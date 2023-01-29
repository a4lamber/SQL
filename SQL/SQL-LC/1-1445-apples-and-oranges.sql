# Write your MySQL query statement below

# Approach 1: intuition
# WITH CTE AS
# (
# SELECT
#     *,
#     lag(sold_num, 1) over(partition by sale_date) as dummy_column
# FROM
#     Sales
# )
# SELECT
#     sale_date,
#     dummy_column - sold_num AS diff
# FROM
#     CTE
# WHERE dummy_column IS NOT NULL

# Approach 2: case when来manipulate column 做四则运算
select 
    sale_date, 
    sum(case when fruit='apples' then sold_num else -sold_num end) as diff
from sales
group by sale_date
