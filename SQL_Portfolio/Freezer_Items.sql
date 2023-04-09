CREATE TABLE freezer_items (
  ID INTEGER PRIMARY KEY,
  Item_Name varchar(200),
  Frozen_Date DATE,
  Expiration_Date DATE
);
--------------------------------------------------------------
INSERT INTO freezer_items (ID, Item_Name, Frozen_Date, Expiration_Date) VALUES
  (1, 'Steak', '2023-02-15', '2023-08-15'),
  (2, 'Veggie Mix', '2022-11-30', '2023-05-30'),
  (3, 'Chicken Breasts', '2022-12-15', '2023-06-15'),
  (4, 'Blueberries', '2022-09-01', '2023-03-01'),
  (5, 'Fish Fillets', '2023-01-10', '2023-07-10'),
  (6, 'Pizza', '2022-10-15', '2023-04-15'),
  (7, 'Ice Cream', '2022-12-20', '2023-06-20'),
  (8, 'Corn on the Cob', '2022-08-01', '2023-02-01'),
  (9, 'Frozen Peas', '2023-02-01', '2023-08-01'),
  (10, 'Shrimp', '2022-11-01', '2023-05-01'),
  (11,'Steak', '2023-03-15', '2023-09-15'),
  (12,'Chicken Breasts', '2022-12-16', '2023-06-16'),
  (13,'Chicken Breasts', '2022-12-17', '2023-06-17'),
  (14,'Chicken Breasts', '2022-12-18', '2023-06-18');
  --------------------------------------------------------------

--CHECKING HOW MANY DISTINCT ITEMS ARE IN YOUR FREEZER
SELECT COUNT(DISTINCT Item_Name)
FROM freezer_items
--------------------------------------------------------------
--CREATING A COLUMN THAT COUNTS HOW MANY OF EACH ITEM YOU HAVE USING PARTITION BY AND THEN TURNING IT INTO ITS OWN TABLE
SELECT *
INTO CountFrozenItems
FROM (
SELECT 
ID, 
Item_Name, 
Frozen_Date, 
Expiration_Date, 
COUNT(Item_Name) OVER (
PARTITION BY Item_Name
) Item_Count
FROM freezer_items
) AS ABC

SELECT * FROM CountFrozenItems
--------------------------------------------------------------
--ADDING AN EXPIRED OR NOT COLUMN JUST FOR FUN
SELECT *,
CASE
	WHEN Expiration_Date<=GETDATE() THEN 'EXPIRED'
	WHEN Expiration_Date <= DATEADD(month, 3, GETDATE()) THEN 'Use Soon'
	ELSE ''
END AS Is_Expired
FROM CountFrozenItems
Order By ID

--------------------------------------------------------------

--Distninct will return each unique item
SELECT DISTINCT Item_Name
FROM freezer_items
--------------------------------------------------------------
--If you want to add more columns then the distinct function will not know how to show those other columns.
--it doenst know how to show you a distinct name if the dates are not distinct as well so it just shows everything.
SELECT DISTINCT Item_Name, Frozen_Date, Expiration_Date
FROM freezer_items
--------------------------------------------------------------
--using an agregate function like MIN() will show only the earliest date  for the Distinct item but you do that with group by.
SELECT Item_Name, MIN(Frozen_Date) AS First_Frozen, MIN(Expiration_Date) AS First_Expired
FROM freezer_items
GROUP BY Item_Name

--------------------------------------------------------------
--QUERY THE TABLE FOR A SPECIFIC ITEM
SELECT *
FROM CountFrozenItems
WHERE Item_Name Like 'c%' --starts with a C
--WHERE Item_Name Like '%c' --ends with a C
--WHERE Item_Name Like '%c%' --has a c in the word at any position
--WHERE Item_Name Like '%_h%' --has an h in the second position
--WHERE Item_Name Like 'c___%' --starts with a c and is at least 4 characters long
--WHERE Item_Name Like 'c%n' --starts with a c and ends with an n
ORDER BY Expiration_Date
--------------------------------------------------------------
--SHOWING EACH ITEM AND HOW MANY OF IT YOU HAVE
SELECT Item_Name, COUNT(Item_Name) AS Item_Count
FROM freezer_items
GROUP BY Item_Name
--------------------------------------------------------------
--FINDING THE OLDEST THING IN THE FREEZER
SELECT *,
	CASE
		WHEN Expiration_Date<=GETDATE() THEN 'EXPIRED'
		ELSE ''
	END AS Is_Expired
FROM CountFrozenItems
WHERE Expiration_Date = (
	SELECT MIN(Expiration_Date)
	FROM CountFrozenItems
) 
