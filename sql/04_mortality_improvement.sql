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

