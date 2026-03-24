-- most_popular_transport_types
-- Copy code into first SQL cell
SELECT journey_type, 
	SUM(journeys_millions) as total_journeys_millions
FROM tfl.journeys
GROUP BY journey_type
ORDER BY total_journeys_millions DESC;

-- emirates_airline_popularity
-- Copy code into second SQL cell
SELECT month, 
	year, 
	ROUND(journeys_millions,2) AS rounded_journeys_millions
FROM tfl.journeys
WHERE journey_type = 'Emirates Airline' AND rounded_journeys_millions IS NOT NULL
ORDER BY rounded_journeys_millions DESC
LIMIT 5;

-- least_popular_years_tube
-- Copy code into third SQL cell
SELECT year,
	journey_type,
	SUM(journeys_millions) as total_journeys_millions
FROM tfl.journeys
WHERE journey_type LIKE '%Underground%'
GROUP BY year, journey_type
ORDER BY total_journeys_millions
LIMIT 5;
