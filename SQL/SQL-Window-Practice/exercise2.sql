# Exercise 2: Create a new column that calculates average Unit Price for each group of CustomerId AND EmployeeId
SELECT
    CustomerID,
    EmployeeID,
	AVG(UnitPrice) OVER(PARTITION BY CustomerID, EmployeeID) 
FROM 
	Orders AS a
INNER JOIN OrderDetails AS b ON a.OrderID = b.OrderID
ORDER BY CustomerID, EmployeeID