--Use Northwind database. All questions are based on assumptions described by the Database Diagram sent to you yesterday. When inserting, make up info if necessary. Write query for each step. Do not use IDE. BE CAREFUL WHEN DELETING DATA OR DROPPING TABLE.
USE Northwind
Go
--1.      Create a view named “view_product_order_[your_last_name]”, list all products and total ordered quantity for that product.
CREATE VIEW view_product_order_vogel 
AS
SELECT p.productId, p.ProductName, SUM(od.quantity) OrderedQuantity
FROM Products p JOIN [Order Details] od ON p.ProductID = od.ProductID
GROUP BY p.ProductID, p.ProductName

--2.      Create a stored procedure “sp_product_order_quantity_[your_last_name]” that accept product id as an input and total quantities of order as output parameter.
CREATE PROC sp_product_order_quantity_vogel
@id AS INT
AS
BEGIN
DECLARE @orderQuantity AS INT
SELECT @orderQuantity = SUM(quantity) FROM [Order Details] WHERE ProductID = @id
RETURN @orderQuantity
END

--3.      Create a stored procedure “sp_product_order_city_[your_last_name]” that accept product name as an input and top 5 cities that ordered most that product combined with the total quantity of that product ordered from that city as output.
CREATE PROC sp_product_order_city_vogel
@productName VARCHAR(255)
AS
BEGIN
SELECT TOP 5 c.City, SUM(od.Quantity) * COUNT(od.ProductID) AmountOrdered
FROM Customers c JOIN Orders o ON c.CustomerID = o.CustomerID JOIN [Order Details] od ON o.OrderID = od.OrderID JOIN Products p ON od.ProductID = p.ProductID
WHERE p.ProductName = @productName
GROUP BY c.City
ORDER BY AmountOrdered DESC
END

BEGIN
EXEC sp_product_order_city_vogel [Louisiana Hot Spiced Okra]
End

--4.      Create 2 new tables “people_your_last_name” “city_your_last_name”. City table has two records: {Id:1, City: Seattle}, {Id:2, City: Green Bay}. People has three records: {id:1, Name: Aaron Rodgers, City: 2}, {id:2, Name: Russell Wilson, City:1}, {Id: 3, Name: Jody Nelson, City:2}. Remove city of Seattle. If there was anyone from Seattle, put them into a new city “Madison”. Create a view “Packers_your_name” lists all people from Green Bay. If any error occurred, no changes should be made to DB. (after test) Drop both tables and view.
CREATE TABLE city_vogel(
	Id		INT			IDENTITY(1,1),
	City	VARCHAR(50) NOT NULL,

	CONSTRAINT PK_city_vogel PRIMARY KEY (Id)
);

CREATE TABLE people_vogel(
	Id		INT			IDENTITY(1,1),
	Name	VARCHAR(50)	NOT NULL,
	City	INT,

	CONSTRAINT PK_people_vogel		PRIMARY KEY (Id),
	CONSTRAINT FK_people_city_vogel	FOREIGN KEY (City)	REFERENCES city_vogel(Id) ON DELETE SET NULL
);

INSERT INTO city_vogel (City) VALUES ('Seattle');
INSERT INTO city_vogel (City) VALUES ('Green Bay');

INSERT INTO people_vogel (Name, City) VALUES ('Aaron Rodgers', 2);
INSERT INTO people_vogel (Name, City) VALUES ('Russell Wilson', 1);
INSERT INTO people_vogel (Name, City) VALUES ('Jordy Nelson', 2);

SELECT * FROM city_vogel
SELECT * FROM people_vogel

DELETE
FROM city_vogel
WHERE City = 'Seattle'

SELECT * FROM city_vogel
SELECT * FROM people_vogel

INSERT INTO city_vogel (City) VALUES ('Madison');

BEGIN
DECLARE @cityID INT
SELECT @cityId = Id From city_vogel WHERE City = 'Madison';
UPDATE people_vogel SET City = @CityId WHERE City IS NULL;
END

SELECT * FROM city_vogel;
SELECT * FROM people_vogel;

CREATE VIEW Packers_vogel
AS
SELECT p.Name
FROM city_vogel c JOIN people_vogel p ON c.Id = p.City
WHERE c.City = 'Green Bay';


DELETE city_vogel;
DROP TABLE people_vogel;
DROP TABLE city_vogel;
DROP VIEW Packers_vogel;

--5.       Create a stored procedure “sp_birthday_employees_[you_last_name]” that creates a new table “birthday_employees_your_last_name” and fill it with all employees that have a birthday on Feb. (Make a screen shot) drop the table. Employee table should not be affected.

--6.      How do you make sure two tables have the same data?
-- This is done using referential integrity via Foreign Keys