

SELECT 
    a.CustomerID,
    b.UnitPrice,
    AVG(UnitPrice) OVER (PARTITION BY CustomerID) AS Avg_unit_price
FROM Orders a
INNER JOIN OrderDetails b ON a.OrderId = b.OrderID 

