# Write your MySQL query statement below

(SELECT
    u.name AS results
FROM
    MovieRating AS m
INNER JOIN Users AS u ON m.user_id = u.user_id
GROUP BY m.user_id
ORDER BY Count(*) DESC, u.name ASC
LIMIT 1)

UNION ALL

(SELECT
    b.title AS results
FROM
    MovieRating AS m
INNER JOIN Movies as b ON m.movie_id = b.movie_id
WHERE YEAR(m.created_at) = 2020 AND MONTH(m.created_at) = 2
GROUP BY m.movie_id
ORDER BY AVG(rating) DESC, b.title ASC
LIMIT 1);
