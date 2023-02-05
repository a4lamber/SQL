# Write your MySQL query statement below

SELECT  
    COUNT(*) AS accounts_count
FROM
    Subscriptions AS sub
LEFT JOIN Streams AS ream
ON sub.account_id = ream.account_id
WHERE ((YEAR(sub.start_date) = 2020 AND YEAR(sub.end_date) = 2021)
OR (YEAR(sub.start_date) = 2021 AND YEAR(sub.end_date) = 2022))
AND YEAR(stream_date) != 2021
