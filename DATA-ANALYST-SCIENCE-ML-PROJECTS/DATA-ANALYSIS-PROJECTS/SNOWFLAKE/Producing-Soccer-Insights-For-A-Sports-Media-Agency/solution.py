-- Copy code into first SQL cell
-- TEAM_HOME_WITH_MOST_GOALS
-- Output the name of the home team and their score           
SELECT TEAM_NAME_HOME, TEAM_HOME_SCORE
-- Select UEFA Champions League 2020-21
FROM SOCCER.TBL_UEFA_2020
-- Descending on TEAM_HOME_SCORE and limiting to the top 3 teams
ORDER BY TEAM_HOME_SCORE DESC 
LIMIT 3; 

-- Copy code into second SQL cell
-- TEAM_WITH_MAJORITY_POSSESSION
SELECT
    CASE 
		-- Home team name if they had more possession
		WHEN POSSESSION_HOME > POSSESSION_AWAY THEN TEAM_NAME_HOME
		-- Away team name if they had more possession
		WHEN POSSESSION_AWAY > POSSESSION_HOME THEN TEAM_NAME_AWAY
		ELSE NULL END AS TEAM_NAME,
	COUNT(*) AS GAME_COUNT
FROM SOCCER.TBL_UEFA_2021
-- Group by team, order by number of games in descending order
-- and limit the results
GROUP BY TEAM_NAME
ORDER BY GAME_COUNT DESC
LIMIT 1;

-- Copy code into third SQL cell
-- TEAM_WON_DUEL_LOST_GAME_STAGE_WISE
-- Output Stage of the game
SELECT STAGE,
	CASE
    -- Select home team which won the duel but lost game
    WHEN DUELS_WON_HOME > DUELS_WON_AWAY AND TEAM_HOME_SCORE < TEAM_AWAY_SCORE THEN TEAM_NAME_HOME
    -- Select away team which won the duel but lost game
    WHEN DUELS_WON_AWAY > DUELS_WON_HOME AND TEAM_AWAY_SCORE < TEAM_HOME_SCORE THEN TEAM_NAME_AWAY
    ELSE NULL
    -- Alias the name of the team which lost the game as TEAM_LOST
    END AS TEAM_LOST    
FROM SOCCER.TBL_UEFA_2022
-- Filter where the duel and score conditions were met
WHERE TEAM_LOST IS NOT NULL;