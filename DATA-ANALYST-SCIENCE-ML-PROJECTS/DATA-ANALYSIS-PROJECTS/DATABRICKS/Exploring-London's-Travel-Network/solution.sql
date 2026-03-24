-- most_popular_transport_types
-- Copy code into first SQL cell
-- Get the journey type and total number of journeys per type
SELECT journey_type, 
	SUM(journeys_millions) as total_journeys_millions
FROM tfl.journeys
-- Group by type of journey and order the results
GROUP BY journey_type
ORDER BY total_journeys_millions DESC;

-- emirates_airline_popularity
-- Copy code into second SQL cell
SELECT month, 
	year, 
    -- Round journeys_millions to two decimal places and alias the column name
	ROUND(journeys_millions,2) AS rounded_journeys_millions
FROM tfl.journeys
-- Filter for cable car journeys and remove dates with zero journeys
WHERE journey_type = 'Emirates Airline' AND journeys_millions IS NOT NULL
ORDER BY rounded_journeys_millions DESC
LIMIT 5;

-- least_popular_years_tube
-- Copy code into third SQL cell
SELECT year,
	journey_type,
	SUM(journeys_millions) as total_journeys_millions
FROM tfl.journeys
-- Filter for Underground & DLR journeys
WHERE journey_type LIKE '%Underground%'
GROUP BY year, journey_type
ORDER BY total_journeys_millions
LIMIT 5;
