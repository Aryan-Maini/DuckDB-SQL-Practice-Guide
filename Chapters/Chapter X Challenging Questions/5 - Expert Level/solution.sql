WITH AGGREGATED_STATS AS (
    SELECT PLAYER_ID, 
           SUM(KILLS) AS KILL, 
           SUM(HEALS) AS HEAL
    FROM STATS
    GROUP BY PLAYER_ID
),
AGGREGATED_STATS_UNPIVOTED AS (UNPIVOT AGGREGATED_STATS
ON KILL, HEAL
INTO NAME OBJECTIVE
VALUE METRIC)
, COMPLETED_OBJECTIVES AS (
FROM AGGREGATED_STATS_UNPIVOTED A
INNER JOIN QUESTS Q
ON 
    A.PLAYER_ID = Q.PLAYER_ID
    AND 
    A.OBJECTIVE = Q.OBJECTIVE
WHERE 
A.METRIC > Q.METRIC)

SELECT  P.PLAYER_ID, P.PLAYER_NAME,
        LISTAGG(C.OBJECTIVE) AS COMPLETED_OBJECTIVES,
        LISTAGG(C.QUEST_REWARD) AS QUEST_REWARDS
FROM COMPLETED_OBJECTIVES C
JOIN PLAYERS P
ON COMPLETED_OBJECTIVES.PLAYER_ID = P.PLAYER_ID
GROUP BY PLAYER_ID
; 
/*


WITH AGGREGATED_STATS AS (
    SELECT 
        PLAYER_ID, 
        SUM(KILLS) AS TOTAL_KILLS, 
        SUM(HEALS) AS TOTAL_HEALS
    FROM STATS
    GROUP BY PLAYER_ID
)
SELECT 
    A.PLAYER_ID
FROM 
    AGGREGATED_STATS A
JOIN 
    QUESTS Q_KILLS
ON 
    A.PLAYER_ID = Q_KILLS.PLAYER_ID
    AND Q_KILLS.OBJECTIVE = 'KILLS'
    AND A.TOTAL_KILLS > Q_KILLS.METRIC
JOIN 
    QUESTS Q_HEALS
ON 
    A.PLAYER_ID = Q_HEALS.PLAYER_ID
    AND Q_HEALS.OBJECTIVE = 'HEALS'
    AND A.TOTAL_HEALS > Q_HEALS.METRIC;

/*
This query aggregates the stats for each player, calculating total kills and heals.
It then joins the aggregated stats with the QUESTS table twice: once for kills and once for
heals. The conditions ensure that the player's total kills exceed the required metric for kills and total heals exceed the required metric for heals.
The final result returns the player IDs that meet both conditions.
*/
-- The query using unpivot was complex and not necessary for the task at hand.
-- however, if the number of objectives increases, maintaining the second query with joins
-- could become cumbersome. In such cases, the original unpivot approach could be revisited.