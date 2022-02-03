USE AdventureWorks2019
GO

--1.      How many products can you find in the Production.Product table?
SELECT COUNT(*) products
FROM Production.Product;

--2.      Write a query that retrieves the number of products in the Production.Product table that are included in a subcategory. The rows that have NULL in column ProductSubcategoryID are considered to not be a part of any subcategory.
SELECT COUNT(ProductSubcategoryID) products
FROM Production.Product

--3.      How many Products reside in each SubCategory? Write a query to display the results with the following titles.

--ProductSubcategoryID CountedProducts

---------------------- ---------------
SELECT ProductSubcategoryID, COUNT(ProductSubcategoryId) CountedProducts
FROM Production.Product
WHERE ProductSubcategoryID IS NOT NULL
GROUP BY ProductSubcategoryID;

--4.      How many products that do not have a product subcategory.
SELECT COUNT(*) CountedProductsWithNoSubcategory
FROM Production.Product
WHERE ProductSubcategoryId IS NULL;

--5.      Write a query to list the sum of products quantity in the Production.ProductInventory table.
SELECT SUM(Quantity) ProductsQuantity
FROM Production.ProductInventory;

--6.    Write a query to list the sum of products in the Production.ProductInventory table and LocationID set to 40 and limit the result to include just summarized quantities less than 100.

--              ProductID    TheSum

--              -----------        ----------
SELECT ProductID, SUM(Quantity) TheSum
FROM Production.ProductInventory
WHERE LocationID = 40 AND Quantity < 100
GROUP BY ProductID;

--7.    Write a query to list the sum of products with the shelf information in the Production.ProductInventory table and LocationID set to 40 and limit the result to include just summarized quantities less than 100

--    Shelf      ProductID    TheSum

--    ----------   -----------        -----------
SELECT Shelf, ProductID, SUM(Quantity) TheSum
FROM Production.ProductInventory
WHERE LocationID = 40 AND Quantity < 100
GROUP BY Shelf, ProductID;

--8. Write the query to list the average quantity for products where column LocationID has the value of 10 from the table Production.ProductInventory table.
SELECT AVG(quantity) AverageQuantityFromLocationID10
FROM Production.ProductInventory
WHERE LocationID = 10;

--9.    Write query  to see the average quantity  of  products by shelf  from the table Production.ProductInventory

--    ProductID   Shelf      TheAvg

--    ----------- ---------- -----------
SELECT ProductID, Shelf, AVG(Quantity) TheAvg
FROM Production.ProductInventory
GROUP BY Shelf, ProductID;


--10.  Write query  to see the average quantity  of  products by shelf excluding rows that has the value of N/A in the column Shelf from the table Production.ProductInventory

--    ProductID   Shelf      TheAvg

--    ----------- ---------- -----------
SELECT ProductID, Shelf, AVG(Quantity) TheAvg
FROM Production.ProductInventory
WHERE Shelf != 'N/A'
GROUP BY Shelf, ProductID;

--11.  List the members (rows) and average list price in the Production.Product table. This should be grouped independently over the Color and the Class column. Exclude the rows where Color or Class are null.

--    Color                        Class              TheCount          AvgPrice

--    -------------- - -----    -----------            ---------------------
SELECT Color, Class, COUNT(*) TheCount, AVG(ListPrice) AvgPrice 
FROM Production.Product
WHERE Color IS NOT NULL AND Class IS NOT NULL
GROUP BY Color, Class
Order BY Color, Class;

--Joins:

--12.   Write a query that lists the country and province names from person. CountryRegion and person. StateProvince tables. Join them and produce a result set similar to the following.

--    Country                        Province

--    ---------                          ----------------------
SELECT pcr.Name Country, psp.Name Province
FROM Person.CountryRegion pcr JOIN Person.StateProvince psp ON pcr.CountryRegionCode = psp.CountryRegionCode;

--13.  Write a query that lists the country and province names from person. CountryRegion and person. StateProvince tables and list the countries filter them by Germany and Canada. Join them and produce a result set similar to the following.

 

--    Country                        Province

--    ---------                          ----------------------
SELECT pcr.Name Country, psp.Name Province
FROM Person.CountryRegion pcr JOIN Person.StateProvince psp ON pcr.CountryRegionCode = psp.CountryRegionCode
WHERE pcr.Name IN ('Germany', 'Canada')
ORDER BY pcr.Name;

-- Using Northwnd Database: (Use aliases for all the Joins)
USE Northwind
GO

--14.  List all Products that has been sold at least once in last 25 years.
SELECT DISTINCT p.ProductID, p.ProductName
FROM Products p JOIN [Order Details] od ON p.ProductID = od.ProductID JOIN Orders o ON od.OrderID = o.OrderID
WHERE o.OrderDate >= '1997-02-02'
ORDER BY p.ProductID;

--15.  List top 5 locations (Zip Code) where the products sold most.
SELECT DISTINCT TOP 5  c.PostalCode, SUM(p.UnitsOnOrder) Sold
FROM Customers c JOIN Orders o ON c.CustomerID = o.CustomerID JOIN [Order Details] od ON o.OrderID = od.OrderID JOIN products p ON od.ProductID = p.ProductID
GROUP BY c.postalCode
ORDER BY Sold DESC;

--16.  List top 5 locations (Zip Code) where the products sold most in last 25 years.
SELECT DISTINCT TOP 5  c.PostalCode, SUM(p.UnitsOnOrder) Sold
FROM Customers c JOIN Orders o ON c.CustomerID = o.CustomerID JOIN [Order Details] od ON o.OrderID = od.OrderID JOIN products p ON od.ProductID = p.ProductID
WHERE o.OrderDate >= '1997-02-02'
GROUP BY c.postalCode
ORDER BY Sold DESC;
 
--17.   List all city names and number of customers in that city.     
SELECT c.City, COUNT(DISTINCT o.CustomerID) CustomersInCity
FROM Customers c LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.city;

--18.  List city names which have more than 2 customers, and number of customers in that city
SELECT c.City, COUNT(DISTINCT o.CustomerID) CustomersInCity
FROM Customers c JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.city
HAVING COUNT(DISTINCT o.CustomerID) > 2;

--19.  List the names of customers who placed orders after 1/1/98 with order date.
SELECT DISTINCT c.ContactName
FROM Customers c JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE o.OrderDate > '1998-01-01';

--20.  List the names of all customers with most recent order dates
SELECT c.ContactName, o.OrderDate
FROM Customers c JOIN Orders o ON c.CustomerID = o.CustomerID
ORDER BY o.OrderDate DESC;

--21.  Display the names of all customers  along with the  count of products they bought
SELECT c.ContactName, COUNT(od.productID) ProductsBought
FROM Customers c JOIN Orders o On c.CustomerID = o.CustomerID JOIN [Order Details] od ON o.OrderID = od.OrderID
GROUP BY c.ContactName;

--22.  Display the customer ids who bought more than 100 Products with count of products.
SELECT c.ContactName, COUNT(od.productID) ProductsBought
FROM Customers c JOIN Orders o On c.CustomerID = o.CustomerID JOIN [Order Details] od ON o.OrderID = od.OrderID
GROUP BY c.ContactName
HAVING COUNT(od.productID) > 100;

--23.  List all of the possible ways that suppliers can ship their products. Display the results as below

--    Supplier Company Name                Shipping Company Name

--    ---------------------------------            ----------------------------------
SELECT Suppliers.CompanyName [Supplier Company Name], Shippers.CompanyName [Shipping Company Name]
FROM Suppliers CROSS JOIN Shippers
ORDER BY [Supplier Company Name];

--24.  Display the products order each day. Show Order date and Product Name.
SELECT o.OrderDate, p.ProductName
FROM Orders o JOIN [Order Details] od ON o.OrderID = od.OrderID JOIN Products p ON od.ProductID = p.ProductID
ORDER BY o.OrderDate;

--25.  Displays pairs of employees who have the same job title.
SELECT e.FirstName + ' ' + e.LastName AS Employee1, e2.FirstName + ' ' + e2.LastName AS Employee2, e.Title
FROM Employees e JOIN Employees e2 ON e.Title = e2.Title;

--26.  Display all the Managers who have more than 2 employees reporting to them.
SELECT  m.FirstName + ' '+ m.LastName as Manager, COUNT(e.FirstName) EmployeesReportingTo
FROM Employees e JOIN Employees m ON e.ReportsTO = m.EmployeeID
GROUP BY m.FirstName, m.LastName
HAVING COUNT(m.FirstName) > 2;

--27.  Display the customers and suppliers by city. The results should have the following columns

--City

--Name

--Contact Name,

--Type (Customer or Supplier)
SELECT City, CompanyName [Name], ContactName [Contact Name], 'Customer' AS Type
From Customers
UNION
SELECT City, CompanyName [Name], ContactName [Contact Name], 'Supplier' AS Type
From Suppliers;