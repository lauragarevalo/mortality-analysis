-- Pandemic Impact

SELECT age,
	MAX(CASE WHEN year = 2019 THEN deaths END) AS deaths_2019,
	MAX(CASE WHEN year = 2020 THEN deaths END) AS deaths_2020,
	MAX(CASE WHEN year = 2021 THEN deaths END) AS deaths_2021,
	MAX(CASE WHEN year = 2020 THEN deaths END) - 
	MAX(CASE WHEN year = 2019 THEN deaths END) AS excess_2020
	MAX(CASE WHEN year = 2021 THEN deaths END) -
        MAX(CASE WHEN year = 2019 THEN deaths END) AS excess_2021
FROM colombia_deaths
WHERE year IN (2019,2020,2021)
GROUP BY age
ORDER BY excess_2020 DESC;

