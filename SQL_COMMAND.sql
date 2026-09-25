-- MoSPI CPI analytical queries
-- Run after the main inflation table has been loaded into PostgreSQL.

SELECT * FROM inflation LIMIT 20;

-- Average inflation by CPI group
DROP TABLE IF EXISTS inflation_groupwise;
CREATE TABLE inflation_groupwise AS
SELECT "Group_i", AVG("Inflation") AS avg_inflation
FROM inflation
GROUP BY "Group_i";

-- Average inflation by group, month and year
DROP TABLE IF EXISTS inflation_groupwise_monthly;
CREATE TABLE inflation_groupwise_monthly AS
SELECT "Year_i", "Month_i", "Group_i",
       AVG("Inflation") AS avg_inflation
FROM inflation
GROUP BY "Year_i", "Month_i", "Group_i"
ORDER BY "Year_i", "Month_i";

-- Average inflation by sector and year
DROP TABLE IF EXISTS inflation_sectorwise;
CREATE TABLE inflation_sectorwise AS
SELECT "Sector", "Year_i",
       AVG("Inflation") AS avg_inflation
FROM inflation
GROUP BY "Sector", "Year_i"
ORDER BY "Year_i", "Sector";

-- Average and standard deviation by year
DROP TABLE IF EXISTS inflation_yearwise;
CREATE TABLE inflation_yearwise AS
SELECT "Year_i",
       AVG("Inflation") AS avg_inflation,
       STDDEV("Inflation") AS stddev_inflation
FROM inflation
GROUP BY "Year_i"
ORDER BY "Year_i";

-- Example inspection queries
SELECT * FROM inflation_groupwise ORDER BY avg_inflation DESC;
SELECT * FROM inflation_sectorwise ORDER BY "Year_i", "Sector";
SELECT * FROM inflation_yearwise ORDER BY "Year_i";
