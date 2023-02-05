# Write your MySQL query statement below

SELECT
    a.student_id,
    a.student_name,
    a.subject_name,
    COALESCE(b.attended_exams, 0) AS attended_exams
FROM
(SELECT * FROM Students JOIN Subjects) AS a
LEFT JOIN 
(SELECT *,count(*) AS attended_exams FROM Examinations AS dum GROUP BY student_id,subject_name) AS b
ON a.student_id = b.student_id and a.subject_name = b.subject_name
ORDER BY student_id,subject_name
