# Exercise 3: Create a new column that ranks Unit Price in descending order for each CustomerId.

# Solution 1: with row_number()
-- SELECT
-- 	CustomerId,
--     OrderDate,
--     b.UnitPrice,
--     ROW_NUMBER() OVER(PARTITION BY a.CustomerId ORDER BY UnitPrice DESC)
-- FROM
-- 	Orders AS a
-- INNER JOIN OrderDetails AS b ON a.OrderID = b.OrderID;


# Solution 2: with rank()
SELECT
	CustomerId,
    OrderDate,
    b.UnitPrice,
    RANK() OVER(PARTITION BY CustomerId ORDER BY UnitPrice DESC) AS unitrank
FROM
	Orders AS a
INNER JOIN OrderDetails AS b ON a.OrderID = b.OrderID;

