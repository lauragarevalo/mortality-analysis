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

