--Write queries for following scenarios - Using AdventureWorks Database
USE AdventureWorks2019
GO
--1. Write a query that retrieves the columns ProductID, Name, Color and ListPrice from the Production.Product table, with no filter.

SELECT P.ProductID, P.Name, P.Color, P.ListPrice
FROM Production.Product P;

--2. Write a query that retrieves the columns ProductID, Name, Color and ListPrice from the Production.Product table, excludes the rows that ListPrice is 0.

SELECT P.ProductID, P.Name, P.Color, P.ListPrice
FROM Production.Product P
WHERE P.ListPrice <> 0;

--3. Write a query that retrieves the columns ProductID, Name, Color and ListPrice from the Production.Product table, the rows that are NULL for the Color column.

SELECT P.ProductID, P.Name, P.Color, P.ListPrice
FROM Production.Product P
WHERE P.Color IS NULL;

--4. Write a query that retrieves the columns ProductID, Name, Color and ListPrice from the Production.Product table, the rows that are not NULL for the Color column.

SELECT P.ProductID, P.Name, P.Color, P.ListPrice
FROM Production.Product P
WHERE P.Color IS NOT NULL;

--5. Write a query that retrieves the columns ProductID, Name, Color and ListPrice from the Production.Product table, the rows that are not NULL for the column Color, and the column ListPrice has a value greater than zero.

SELECT P.ProductID, P.Name, P.Color, P.ListPrice
FROM Production.Product P
WHERE P.Color IS NOT NULL AND P.ListPrice > 0;

--6. Write a query that concatenates the columns Name and Color from the Production.Product table by excluding the rows that are null for color.

SELECT P.Name + P.Color AS NameColor
FROM Production.Product P
WHERE P.Color IS NOT NULL;

--7. Write a query that generates the following result set  from Production.Product:
	--1. NAME: LL Crankarm  --  COLOR: Black
	--2. NAME: ML Crankarm  --  COLOR: Black
	--3. NAME: HL Crankarm  --  COLOR: Black
	--4. NAME: Chainring Bolts  --  COLOR: Silver
	--5. NAME: Chainring Nut  --  COLOR: Silver
	--6. NAME: Chainring  --  COLOR: Black

SELECT 'NAME: ' + P.Name + ' -- COLOR: ' + P.Color AS [Name & Color]
FROM Production.Product P
WHERE P.Color IS NOT NULL;

--8. Write a query to retrieve the to the columns ProductID and Name from the Production.Product table filtered by ProductID from 400 to 500

SELECT P.ProductID, P.Name
FROM Production.Product P
WHERE P.ProductID BETWEEN 400 AND 500;

--9. Write a query to retrieve the to the columns  ProductID, Name and color from the Production.Product table restricted to the colors black and blue

SELECT P.ProductID, P.Name, P.Color
FROM Production.Product P
WHERE P.Color IN ('black', 'blue');

--10. Write a query to get a result set on products that begins with the letter S. 

SELECT P.Name
FROM Production.Product P
WHERE P.Name LIKE 'S%';

--11. Write a query that retrieves the columns Name and ListPrice from the Production.Product table. Your result set should look something like the following. Order the result set by the Name column. 
	--1. Name                                               ListPrice
	--2. Seat Lug                                              0,00
	--3. Seat Post                                             0,00
	--4. Seat Stays                                            0,00
	--5. Seat Tube                                            0,00
	--6. Short-Sleeve Classic Jersey, L           53,99
	--7. Short-Sleeve Classic Jersey, M          53,99

SELECT P.Name, P.ListPrice
FROM Production.Product P
WHERE P.Name LIKE 'S%'
ORDER BY P.Name;

--12. Write a query that retrieves the columns Name and ListPrice from the Production.Product table. Your result set should look something like the following. Order the result set by the Name column. The products name should start with either 'A' or 'S'
	--1. Name                                               ListPrice
	--2. Adjustable Race                                   0,00
	--3. All-Purpose Bike Stand                       159,00
	--4. AWC Logo Cap                                      8,99
	--5. Seat Lug                                                 0,00
	--6. Seat Post                                                0,00

SELECT P.Name, P.ListPrice
FROM Production.Product P
WHERE P.Name LIKE 'S%' OR P.Name LIKE 'A%'
ORDER BY P.Name;

--13. Write a query so you retrieve rows that have a Name that begins with the letters SPO, but is then not followed by the letter K. After this zero or more letters can exists. Order the result set by the Name column.

SELECT P.Name
FROM Production.Product P
WHERE P.Name LIKE 'SPO[^K]%'
ORDER BY P.Name;

--14. Write a query that retrieves unique colors from the table Production.Product. Order the results  in descending  manner

SELECT Distinct P.Color
FROM Production.Product P
WHERE P.Color IS NOT NULL
ORDER BY P.Color DESC;

--15. Write a query that retrieves the unique combination of columns ProductSubcategoryID and Color from the Production.Product table. Format and sort so the result set accordingly to the following. We do not want any rows that are NULL.in any of the two columns in the result.

SELECT P.ProductSubcategoryID, P.Color
FROM Production.Product P
WHERE P.ProductSubcategoryID IS NOT NULL AND P.Color IS NOT NULL;