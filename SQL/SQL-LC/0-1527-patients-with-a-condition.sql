# Write your MySQL query statement below
SELECT
    patient_id,
    patient_name,
    conditions
FROM
    Patients 
WHERE 
    conditions LIKE 'DIAB1%'
    OR conditions LIKE '% DIAB1%';
    
/*
Trick is to avoid exceptions like 'ADIAB100 COUGH';
Also really helpful to know a trick for each word in a sentence
as long as it's countable. What about >3 words tho like
'ADIAB100 COUGH BADIAB100'. We prob need a more general way of 
doing it when test cases are more stricter.
*/
