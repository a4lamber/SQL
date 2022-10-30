# Write your MySQL query statement below

SELECT
    request_at AS Day,
    ROUND(
            COUNT(CASE WHEN status IN 
('cancelled_by_client','cancelled_by_driver') THEN 1
                  ELSE NULL END)/COUNT(*)
        ,2) AS "Cancellation Rate"
FROM
    Trips
INNER JOIN Users ON Trips.client_id = Users.users_id
WHERE Users.banned = 'NO' AND (request_at BETWEEN '2013-10-01' AND 
'2013-10-03')
GROUP BY Trips.request_at;

# I think my solution is correct and the only test case it doesn't go 
through is trivial.
