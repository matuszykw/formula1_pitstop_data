-- Deleting all pit stops with time > 150
-- These are red flags not pit stops
DELETE FROM pit_stop_data
WHERE PitDuration > 150;

-- Average pit stop time for a team
SELECT Team, round(AVG(PitDuration), 3) AS AveragePitTime
FROM pit_stop_data
GROUP BY Team
ORDER BY AveragePitTime ASC;

-- Teams with most pit stops
SELECT Team, count(*) as TotalPitStops
FROM pit_stop_data
GROUP BY Team
ORDER BY TotalPitStops DESC;

-- Fastest pit = better position?
SELECT
    CASE
        WHEN Position <= 3 THEN 'Podium'
        WHEN Position BETWEEN 4 AND 10 THEN 'Points'
        ELSE 'No points'
    END AS RaceResults,
    ROUND(AVG(PitDuration), 3) AS AvgPitTime
FROM pit_stop_data
GROUP BY RaceResults;


SELECT
    Race,
    Team,
    AVG(PitDuration) as AvgPitTime,
    rank() OVER (PARTITION BY Race ORDER BY AVG(PitDuration)) as TeamRank
FROM pit_stop_data
GROUP BY Race, Team;

-- Most common compound changes
SELECT TyreBefore, TyreAfter, count(*) as TotalChanges
FROM pit_stop_data
GROUP BY TyreBefore, TyreAfter
ORDER BY TotalChanges DESC;
