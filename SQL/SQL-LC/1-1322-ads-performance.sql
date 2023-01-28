# Write your MySQL query statement below

SELECT
    ad_id,
    COALESCE(
        ROUND(
            COUNT(CASE WHEN action = 'Clicked' THEN 1 ELSE NULL END)/
            (COUNT(CASE WHEN action = 'Clicked' THEN 1 ELSE NULL END) 
        + COUNT(CASE WHEN action = 'Viewed' THEN 1 ELSE NULL END)) * 100.0,2)
    ,0) AS ctr
FROM
    Ads
GROUP BY ad_id
ORDER BY ctr DESC, ad_id ASC;
