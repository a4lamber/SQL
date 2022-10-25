SELECT 
    class
FROM
    Courses
GROUP BY class
HAVING COUNT(*) >= 5;

# practice groupby + having clause;
