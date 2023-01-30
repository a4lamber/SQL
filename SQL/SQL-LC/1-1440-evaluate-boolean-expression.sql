# Write your MySQL query statement below



WITH left_table AS
(
SELECT
    row_number() OVER() AS id,
    v.value AS left_operand
FROM
    Expressions AS e
INNER JOIN Variables AS v ON e.left_operand = v.name
),
right_table AS
(
SELECT
    row_number() OVER() AS id,
    e.operator AS operator,
    v.value AS right_operand
FROM
    Expressions AS e
INNER JOIN Variables AS v ON e.right_operand = v.name
),
new_expression AS
(
    SELECT
        row_number() OVER() AS id,
        Expressions.*
    FROM
        Expressions
)
SELECT 
    n.left_operand,
    r.operator,
    n.right_operand,
    CASE WHEN l.left_operand = r.right_operand and r.operator = '=' THEN 'true'
         WHEN l.left_operand - r.right_operand > 0 and r.operator = '>' THEN 'true'
         WHEN l.left_operand - r.right_operand < 0 and r.operator = '<' THEN 'true'
         ELSE 'false' END AS value
FROM
    left_table AS l 
INNER JOIN right_table AS r ON l.id = r.id
INNER JOIN new_expression AS n ON r.id = n.id
