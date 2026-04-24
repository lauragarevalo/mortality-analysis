

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
		



