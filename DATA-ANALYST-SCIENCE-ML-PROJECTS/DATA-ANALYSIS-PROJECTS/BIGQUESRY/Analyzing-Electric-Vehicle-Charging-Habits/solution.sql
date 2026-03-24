-- unique_users_per_garage
-- Please paste code into first cell
SELECT garage_id, 
	COUNT(DISTINCT user_id) AS num_unique_users
FROM VEHICLES.CHARGING_SESSIONS
WHERE user_type = 'Shared'
GROUP BY garage_id
ORDER BY num_unique_users DESC;

-- most_popular_shared_start_times
-- Please paste code into second cell
SELECT weekdays_plugin,
	start_plugin_hour, 
	COUNT(*) AS num_charging_sessions
FROM VEHICLES.CHARGING_SESSIONS
WHERE user_type = 'Shared'
GROUP BY weekdays_plugin,
	start_plugin_hour
ORDER BY num_charging_sessions DESC
LIMIT 10;

-- long_duration_shared_users
-- Please paste code into third cell
SELECT user_id, 
	AVG(duration_hours) as avg_charging_duration
FROM VEHICLES.CHARGING_SESSIONS
WHERE user_type = 'Shared' 
GROUP BY user_id
HAVING AVG(duration_hours) > 10
ORDER BY AVG(duration_hours) DESC;