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

-- Overall trend of Total deaths per year. We can see the deaths increase due to population
-- increase

SELECT year, SUM(deaths) AS total_deaths
FROM colombia_deaths
GROUP BY year
ORDER BY year;

-- Age group with most deaths each year

SELECT year, age, deaths
FROM colombia_deaths
WHERE (year, deaths) IN (
	SELECT year, MAX(deaths)
	FROM colombia_deaths
	GROUP BY year
)
ORDER BY year;

-- From 1950 to 2019 the deadliest age was 0. This shifts in 2020 (probably due to the pandemic)

-- Mortality improvement over time 

SELECT age,
	MAX(CASE WHEN year = 1950 THEN deaths END) AS deaths_1950,
	MAX(CASE WHEN year = 2023 THEN deaths END) AS deaths_2023,
	ROUND((MAX(CASE WHEN year = 1950 THEN deaths END) - 
		   MAX(CASE WHEN year = 2023 THEN deaths END)) * 100.0 /
		   MAX(CASE WHEN year = 1950 THEN deaths END),1
	) AS pct_reduction
FROM colombia_deaths
GROUP BY age
ORDER BY pct_reduction DESC, age::INT;

-- We see an 80%-97% reduction in ages 1-10 and an increase of deaths in ages greater than 26

-- Deaths by age group

SELECT year,
	CASE
		WHEN age BETWEEN 0 AND 14 THEN '0-14'
		WHEN age BETWEEN 15 AND 29 THEN '15-29'
		WHEN age BETWEEN 30 AND 44 THEN '30-44'
		WHEN age BETWEEN 45 AND 59 THEN '45-59'
		WHEN age BETWEEN 60 AND 74 THEN '60-74'
		ELSE '75+'
	END AS age_group,
	SUM(deaths) AS total_deaths
FROM colombia_deaths
GROUP BY year, age_group
ORDER BY year, age_group;

-- Average age at death per year

SELECT year,
	ROUND(SUM(age * deaths) * 1.0 / SUM(deaths), 1) AS avg_age_at_death
FROM colombia_deaths
GROUP BY year
ORDER BY year;

-- Pandemic Impact

SELECT age,
	MAX(CASE WHEN year = 2019 THEN deaths END) AS deaths_2019,
	MAX(CASE WHEN year = 2020 THEN deaths END) AS deaths_2020,
	MAX(CASE WHEN year = 2021 THEN deaths END) AS deaths_2021,
	MAX(CASE WHEN year = 2020 THEN deaths END) - 
	MAX(CASE WHEN year = 2019 THEN deaths END) AS excess_2020
FROM colombia_deaths
WHERE year IN (2019,2020,2021)
GROUP BY age
ORDER BY excess_2020 DESC;

SELECT age,
    MAX(CASE WHEN year = 2020 THEN deaths END) -
    MAX(CASE WHEN year = 2019 THEN deaths END) AS excess_2020,
    MAX(CASE WHEN year = 2021 THEN deaths END) -
    MAX(CASE WHEN year = 2019 THEN deaths END) AS excess_2021
FROM colombia_deaths
WHERE year IN (2019, 2020, 2021)
GROUP BY age
ORDER BY excess_2020 DESC
LIMIT 15;

-- Specific years with the highest total excess deaths

SELECT year,
	SUM(deaths) AS total_deaths,
	SUM(deaths) - LAG(SUM(deaths)) OVER (ORDER BY year) AS change_from_prior_year
FROM colombia_deaths
GROUP BY year
ORDER BY change_from_prior_year DESC NULLS LAST
LIMIT 10;
		



