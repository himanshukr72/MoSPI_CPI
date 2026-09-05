select * from inflation;

/*Creating Mean of inflation Groupwise.*/

Create table inflation_Groupwise as
SELECT "Group_i", AVG("Inflation") AS avg_inflation
FROM inflation
GROUP BY "Group_i";

/*Creating Mean of inflation Sectorwise for each year.*/
Create table inflation_Groupwise_yearwise as
SELECT "Year_i","Month_i","Group_i", AVG("Inflation") AS avg_inflation
FROM inflation
GROUP BY "Group_i","Month_i", "Year_i"
order by "Year_i" asc;

/*Creating Mean of inflation Secwise for each year.*/
create table inflation_sectorwise as
SELECT "Sector","Year_i", AVG("Inflation") AS avg_inflation
FROM inflation
GROUP BY "Sector", "Year_i"
order by "Year_i" asc;

/*Creating Mean of inflation Yearwise for each year.*/
create table inflation_yearwise as
SELECT "Year_i", AVG("Inflation") AS avg_inflation
FROM inflation
GROUP BY "Year_i"
order by "Year_i" asc;

/*Creating Mean and std dev of inflation Yearwise for each year.*/
create table inflation_yearwise as
SELECT "Year_i", AVG("Inflation"), STDDEV("Inflation") AS avg_inflation
FROM inflation
GROUP BY "Year_i"
order by "Year_i" asc;


select * from inflation_std_dev_yearwise;

select * from inflation_sectorwise;

