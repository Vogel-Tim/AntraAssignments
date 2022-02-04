USE Northwind
Go
--1.      List all cities that have both Employees and Customers.
SELECT DISTINCT city
FROM customers
WHERE city IN (SELECT city from employees)
--2.      List all cities that have Customers but no Employee.

--a.      Use sub-query
SELECT DISTINCT city
FROM customers
WHERE city NOT IN (SELECT city from employees)

--b.      Do not use sub-query NOT COMPLETED
SELECT DISTINCT c.city
FROM Customers c JOIN Orders o ON c.CustomerID = o.customerId JOIN Employees e ON o.EmployeeID = e.EmployeeID
WHERE c.City != e.City

--3.      List all products and their total order quantities throughout all orders.
SELECT od.OrderId, od.Quantity, p.ProductName
FROM [Order Details] od JOIN Products p ON od.ProductID = p.ProductID;

--4.      List all Customer Cities and total products ordered by that city.
SELECT c.City, SUM(od.quantity) TotalProductsOrdered 
FROM Customers c LEFT JOIN Orders o ON c.CustomerID = o.CustomerID JOIN [Order Details] od ON o.OrderID = od.OrderID
GROUP BY c.City
ORDER BY TotalProductsOrdered DESC;

--5.      List all Customer Cities that have at least two customers.

--a.      Use union

--b.      Use sub-query and no union
SELECT c.City, COUNT(DISTINCT o.CustomerID) AS NumberOfCustomers
FROM Customers c JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.City
HAVING COUNT(DISTINCT o.CustomerID) > 1

--6.      List all Customer Cities that have ordered at least two different kinds of products.
SELECT c.City, COUNT(od.productID) AS ProductsTypesOrdered
FROM Customers c JOIN Orders o ON c.CustomerID = o.CustomerID JOIN [Order Details] od ON o.OrderID = od.OrderID 
GROUP BY c.City
HAVING COUNT(od.productID) > 1

--7.      List all Customers who have ordered products, but have the ‘ship city’ on the order different from their own customer cities.
SELECT DISTINCT c.CustomerID, c.City, o.ShipCity
FROM Customers c JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE c.City != o.ShipCity

--8.      List 5 most popular products, their average price, and the customer city that ordered most quantity of it.
SELECT TOP 5 SUM(od.Quantity) AS UnitsOrdered, od.ProductID, AVG(od.unitPrice) AveragePrice, (SELECT c.City FROM customers c JOIN Orders o ON c.CustomerID = o.CustomerID JOIN [Order Details] od ON o.OrderID = od.OrderID GROUP BY c.City ORDER BY SUM(od.Quantity) DESC)
FROM [Order Details] od
GROUP BY od.ProductID
--9.      List all cities that have never ordered something but we have employees there.

--a.      Use sub-query

--b.      Do not use sub-query

--10.  List one city, if exists, that is the city from where the employee sold most orders (not the product quantity) is, and also the city of most total quantity of products ordered from. (tip: join  sub-query)

--11. How do you remove the duplicates record of a table?