-- 1. Find the most popular escape room themes
SELECT `Escape Rooms`.Theme, COUNT(`Teams_has_Escape Rooms`.TeamID) AS TotalTeams
FROM `Portfolio-3`.`Escape Rooms`
JOIN `Portfolio-3`.`Teams_has_Escape Rooms` ON `Escape Rooms`.RoomID = `Teams_has_Escape Rooms`.`Escape Rooms_RoomID`
GROUP BY `Escape Rooms`.Theme
ORDER BY TotalTeams DESC;

/* Total rows = 4
+---------+----------+
|Theme    |TotalTeams|
+---------+----------+
|Horror   |2         |
|Adventure|1         |
|Sci-Fi   |1         |
|History  |1         |
+---------+----------+
*/

-- 2. Find the top 3 hardest puzzles based on hints used
SELECT P.PuzzleName, SUM(H.UsageCount) AS TotalHintsUsed
FROM `Portfolio-3`.`Hints` H
JOIN `Portfolio-3`.`Puzzles` P ON H.PuzzleID = P.PuzzleID
GROUP BY P.PuzzleName
ORDER BY TotalHintsUsed DESC
limit 3;

/* Total rows = 3
+--------------+--------------+
|PuzzleName    |TotalHintsUsed|
+--------------+--------------+
|Laser Grid    |4             |
|Mirror Maze   |2             |
|Hidden Objects|2             |
+--------------+--------------+
*/

-- 3. Track team completion status by escape room
SELECT Teams.TeamName, `Escape Rooms`.Title AS EscapeRoom, Teams.CompletionStatus
FROM `Portfolio-3`.`Teams`
JOIN `Portfolio-3`.`Teams_has_Escape Rooms` ON Teams.TeamID = `Teams_has_Escape Rooms`.TeamID
JOIN `Portfolio-3`.`Escape Rooms` ON `Teams_has_Escape Rooms`.`Escape Rooms_RoomID` = `Escape Rooms`.RoomID
ORDER BY EscapeRoom, Teams.CompletionStatus;

/*
+------------------+---------------+----------------+
|TeamName          |EscapeRoom     |CompletionStatus|
+------------------+---------------+----------------+
|Code Breakers     |Egyptian Tomb  |Completed       |
|Time Travelers    |Haunted Circus |Completed       |
|The Puzzle Masters|Mystery Mansion|Completed       |
|Escape Artists    |Pirate Cove    |Failed          |
|Mystery Solvers   |Space Odyssey  |In Progress     |
+------------------+---------------+----------------+
*/