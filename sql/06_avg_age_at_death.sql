-- Average age at death per year

SELECT year,
	ROUND(SUM(age * deaths) * 1.0 / SUM(deaths), 1) AS avg_age_at_death
FROM colombia_deaths
GROUP BY year
ORDER BY year;

