CREATE TABLE colombia_deaths (
	year INT,
	age INT,
	deaths INT
);

COPY colombia_deaths (year, age, deaths)
FROM 'C:\data\colombia_deaths_by_age.csv'
WITH (FORMAT csv, HEADER true);

-- verify the loaded data 

SELECT COUNT(*) FROM colombia_deaths;

SELECT * FROM colombia_deaths LIMIT 15;

SELECT year, deaths FROM colombia_deaths
WHERE age = 0
ORDER BY year;

