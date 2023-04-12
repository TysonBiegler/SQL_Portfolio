--Replacing blank cells with NULL
UPDATE realtor_data_Portland_OR
SET 
	Column1 = CASE Column1 WHEN '' THEN NULL ELSE Column1 END,
	[Home Type] = CASE [Home Type] WHEN '' THEN NULL ELSE [Home Type] END,
	[Year Built] = CASE [Year Built] WHEN '' THEN NULL ELSE [Year Built] END,
	Address = CASE Address WHEN '' THEN NULL ELSE Address END,
	[Postal Code] = CASE [Postal Code] WHEN '' THEN NULL ELSE [Postal Code] END,
	Bedrooms = CASE Bedrooms WHEN '' THEN NULL ELSE Bedrooms END,
	Bathrooms = CASE Bathrooms WHEN '' THEN NULL ELSE Bathrooms END,
	[Square Feet] = CASE [Square Feet] WHEN '' THEN NULL ELSE [Square Feet] END,
	Price = CASE Price WHEN '' THEN NULL ELSE Price END,
	[Sold Date] = CASE [Sold Date] WHEN '' THEN NULL ELSE [Sold Date] END,
	[Sold Price] = CASE [Sold Price] WHEN '' THEN NULL ELSE [Sold Price] END
-- -------------------------------------------------------------------------------------------------
--Finding all sales in 2023 (I didnt end up using this)
SELECT *
FROM realtor_data_Portland_OR
WHERE [Sold Date] IS NOT NULL
AND YEAR([Sold Date]) = 2023

-- -------------------------------------------------------------------------------------------------
--Adding a 'sales volume' column
ALTER TABLE realtor_data_Portland_OR
ADD [Sales Volume] DECIMAL(10, 2)

--Calculating sales volume and saving as a view for vizualization purposes
CREATE VIEW [sales_volume_by_year] AS
SELECT YEAR([Sold Date]) AS [Sales Year], SUM([Sold Price]) AS [Sales Volume]
FROM realtor_data_Portland_OR
WHERE [Sold Date] IS NOT NULL
GROUP BY YEAR([Sold Date])

SELECT * FROM sales_volume_by_year

-- -------------------------------------------------------------------------------------------------
--Calculating price trends per year
CREATE VIEW [yearly_price_trends] AS
SELECT YEAR([Sold Date]) AS [Sales Year], ROUND(AVG([Sold Price]), 2) AS [Average Price]
FROM realtor_data_Portland_OR
WHERE [Sold Date] IS NOT NULL
GROUP BY YEAR([Sold Date])

-- -------------------------------------------------------------------------------------------------
--Finding property size distribution
CREATE VIEW property_size_distribution AS
SELECT FLOOR([Square Feet] / 1000) * 1000 AS [Size Range], COUNT(*) AS [Property Count]
FROM realtor_data_Portland_OR
GROUP BY FLOOR([Square Feet] / 1000) * 1000

-- -------------------------------------------------------------------------------------------------
--Finding property age distribution
CREATE VIEW property_age_distribution AS
SELECT [Property Age], COUNT(*) AS [Property Count]
FROM (
  SELECT (YEAR(GETDATE()) - [Year Built]) AS [Property Age]
  FROM realtor_data_Portland_OR
) AS subquery
GROUP BY [Property Age]

CREATE VIEW property_age_distribution AS
SELECT * FROM property_age_distribution ORDER BY [Property Age]


