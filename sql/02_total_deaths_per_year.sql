-- Overall trend of Total deaths per year. We can see the deaths increase due to population
-- increase

SELECT year, SUM(deaths) AS total_deaths
FROM colombia_deaths
GROUP BY year
ORDER BY year;

