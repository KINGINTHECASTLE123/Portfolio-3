-- 1. Query: Find the Most Popular Escape Room Themes
SELECT `Escape Rooms`.Theme, COUNT(`Teams_has_Escape Rooms`.TeamID) AS TotalTeams
FROM `Portfolio-3`.`Escape Rooms`
JOIN `Portfolio-3`.`Teams_has_Escape Rooms` ON `Escape Rooms`.RoomID = `Teams_has_Escape Rooms`.`Escape Rooms_RoomID`
GROUP BY `Escape Rooms`.Theme
ORDER BY TotalTeams DESC;

/*
+---------+----------+
|Theme    |TotalTeams|
+---------+----------+
|Horror   |2         |
|Adventure|1         |
|Sci-Fi   |1         |
|History  |1         |
+---------+----------+
*/

 */
-- 2. Query: Find the Top 3 Hardest Puzzles Based on Hints Used
SELECT Puzzles.PuzzleName, COUNT(Hints.UsageCount) AS HintsRequested
FROM `Portfolio-3`.`Hints`
JOIN `Portfolio-3`.`Puzzles` ON Hints.PuzzleID = Puzzles.PuzzleID
GROUP BY Puzzles.PuzzleName
ORDER BY HintsRequested DESC
LIMIT 3;

/*
+-----------+--------------+
|PuzzleName |HintsRequested|
+-----------+--------------+
|Mirror Maze|1             |
|Cipher Code|1             |
|Laser Grid |1             |
+-----------+--------------+
*/


-- 3. Query: Track Team Completion Status by Escape Room
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