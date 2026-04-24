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

