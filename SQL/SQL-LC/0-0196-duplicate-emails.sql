-- # Please write a DELETE statement and DO NOT write a SELECT statement.
-- # Write your MySQL query statement below

-- # DELETE FROM table_Name WHERE condition
-- # p1 being the one be modified, p2 being the condition

DELETE p1 FROM 
    Person p1, Person p2 
WHERE p1.email = p2.email and p1.id > p2.id;
