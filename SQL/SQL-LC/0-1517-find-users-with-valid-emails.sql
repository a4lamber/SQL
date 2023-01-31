# Write your MySQL query statement below

SELECT 
    * 
FROM Users 
WHERE regexp_like(mail, '^[a-zA-Z]+[A-Za-z0-9\-\.\_]*@leetcode\\.com')

