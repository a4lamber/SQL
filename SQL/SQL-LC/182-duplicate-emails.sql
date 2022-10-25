SELECT
    email
FROM
    Person
GROUP BY email
HAVING COUNT(*) > 1;

# finding duplicates with group by and having
