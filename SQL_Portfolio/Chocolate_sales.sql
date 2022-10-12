-- INTERMEDIATE PROBLEMS-- 
-- 1. Print details of shipments (sales) where amounts are > 2,000 and boxes are <100?
SELECT * FROM sales
where Amount > 2000 AND boxes < 100;
-- RESULTS(TOP 5)
-- SP19	G3	P10	2021-01-01 00:00:00	2387	134	89
-- SP11	G2	P17	2021-01-04 00:00:00	2814	296	94
-- SP07	G4	P13	2021-01-13 00:00:00	2121	130	89
-- SP25	G2	P08	2021-01-14 00:00:00	2135	183	98
-- SP17	G5	P01	2021-01-21 00:00:00	2408	106	90

-- 2. How many shipments (sales) each of the sales persons had in the month of January 2022? 
SELECT people.Salesperson, count(*) as 'Shipments'
FROM people
JOIN sales on sales.SPID=people.SPID
WHERE year(SaleDate) = 2022 AND month(SaleDate) = 01
group by people.Salesperson
Order by shipments DESC;
-- RESULTS(TOP 5)
-- Roddy Speechley	47
-- Kelci Walkden	44
-- Gunar Cockshoot	44
-- Karlen McCaffrey	44
-- Van Tuxwell	43

-- 3. Which product sells more boxes? Milk Bars or Eclairs?
SELECT products.Product, sales.Boxes 
FROM products
JOIN sales on sales.PID = products.PID
WHERE products.Product IN ("Milk Bars","Eclairs")
GROUP BY Product
ORDER BY Boxes DESC;
-- RESULTS
-- Eclairs	975
-- Milk Bars	478

-- 4. Which product sold more boxes in the first 7 days of February 2022? Milk Bars or Eclairs?
SELECT products.Product, sales.Boxes
FROM products
JOIN sales on sales.PID = products.PID
WHERE products.Product IN ("Milk Bars","Eclairs") and sales.SaleDate BETWEEN "2022-2-1" AND "2022-2-7"
GROUP BY Product
ORDER BY Boxes DESC;
-- RESULTS
-- Milk Bars	621
-- Eclairs	57

-- 5. Which shipments had under 100 customers & under 100 boxes? Did any of them occur on Wednesday?
SELECT *
FROM sales
WHERE customers < 100 AND boxes < 100;

-- RESULTS(TOP 5)
-- SP01	G4	P15	2021-01-01 00:00:00	259	32	22
-- SP12	G6	P09	2021-01-04 00:00:00	147	9	11
-- SP09	G5	P09	2021-01-06 00:00:00	539	10	77
-- SP20	G6	P19	2021-01-06 00:00:00	637	79	91
-- SP05	G5	P04	2021-01-08 00:00:00	364	14	21

SELECT *,
CASE
	WHEN weekday(saledate)=1 THEN "Wednesday Shipment"
ELSE ""
END AS "WednesdayShipment"
FROM sales
WHERE customers < 100 AND boxes < 100 AND weekday(saledate)=1
ORDER BY WednesdayShipment DESC;

-- RESULTS(TOP 5)
-- SP08	G4	P16	2021-01-12 00:00:00	721	45	24	Wednesday Shipment
-- SP08	G6	P06	2021-01-19 00:00:00	161	95	10	Wednesday Shipment
-- SP06	G5	P15	2021-01-19 00:00:00	742	80	53	Wednesday Shipment
-- SP18	G6	P05	2021-02-09 00:00:00	980	75	47	Wednesday Shipment
-- SP05	G1	P08	2021-02-16 00:00:00	1239	29	54	Wednesday Shipment;

