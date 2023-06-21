CREATE VIEW Average_Valuation AS
SELECT AVG(Valuation) AS Average_Valuation
FROM Unicorn_Companies_Maven_Analytics

CREATE VIEW Total_Valuation AS
SELECT CAST(AVG(Valuation) AS REAL(38)) * 1000000000 AS Total_Average_Valuation
FROM Unicorn_Companies_Maven_Analytics



CREATE VIEW Unicorns_Per_Year AS
SELECT COUNT(Company) AS Unicorns_Per_Year, [Date Joined]
FROM Unicorn_Companies_Maven_Analytics
GROUP BY [Date Joined]

CREATE VIEW Total_Value AS
SELECT Company, Round(SUM(Valuation + Funding),2) AS Total_Value
FROM Unicorn_Companies_Maven_Analytics
Group by Company

CREATE VIEW FTV AS 
SELECT U.Company, U.Industry, ROUND(SUM(U.Valuation) / V.Total_Value, 2) AS FTV
FROM Unicorn_Companies_Maven_Analytics U
JOIN Total_Value V ON U.Company = V.Company
GROUP BY U.Company, U.Industry, V.Total_Value;

CREATE VIEW Average_FTV AS
SELECT Industry, ROUND(AVG(FTV),2) AS Average_FTV
FROM FTV
GROUP BY Industry

SELECT U.Industry, U.Valuation, F.Average_FTV
FROM Unicorn_Companies_Maven_Analytics U
JOIN FTV F ON U.Industry = F.Industry;

CREATE VIEW Average_Valuation AS
SELECT Industry, ROUND(AVG(Valuation),2) AS Average_Valuation
FROM Unicorn_Companies_Maven_Analytics
GROUP BY Industry


CREATE VIEW Industry_Averages AS
SELECT F.Industry, F.Average_FTV, V.Average_Valuation
FROM Average_FTV F
JOIN Average_Valuation V ON F.Industry = V.Industry;

CREATE VIEW Company_Count AS
Select COUNT(Company) AS Company_Count
FROM Unicorn_Companies_Maven_Analytics
