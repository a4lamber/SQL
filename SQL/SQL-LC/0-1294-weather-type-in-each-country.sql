/* Write your T-SQL query statement below */

/*
Return type of weather in each country for Nov 2019
type of weather defined as:
<= 15, cold
>= 25, hot
else, warm

难点:
- 由于列weather_state的data type是int, 所以在用avg()函数等计算时，记得需要先转化为float,再运算，
不然会有truncation error; rookie mistake 
*/

WITH cte AS
(
SELECT
    country_id,
    CASE WHEN AVG(cast(weather_state AS float)) <= 15.0 THEN 'Cold'
         WHEN AVG(cast(weather_state AS float)) >= 25.0 THEN 'Hot'
         ELSE 'Warm' END as weather_type,
    AVG(weather_state) AS avg_temp
FROM
    Weather
WHERE day between '2019-11-01' and '2019-11-30'
GROUP BY country_id
)
SELECT
    c.country_name,
    cte.weather_type
FROM
    cte
INNER JOIN Countries AS c ON cte.country_id = c.country_id;




