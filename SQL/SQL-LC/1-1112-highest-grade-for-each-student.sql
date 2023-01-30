# Write your MySQL query statement below

WITH CTE AS
(
SELECT
    *,
    RANK() OVER(PARTITION BY student_id ORDER BY grade DESC, course_id ASC) AS ranks
FROM
    Enrollments
)
SELECT
    student_id,
    course_id,
    grade
FROM
    CTE
WHERE ranks = 1;
