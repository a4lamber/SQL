# Write your MySQL query statement below

SELECT
    q.id,
    q.year,
    COALESCE(NPV.npv,0) AS npv
FROM
    Queries AS q
LEFT JOIN NPV ON (q.id = NPV.id AND q.year = NPV.year)

