SELECT
    Teams.TeamName,
    `Escape Rooms`.Title AS EscapeRoom,
    Teams.CompletionStatus
FROM `Portfolio-3`.`Teams`
JOIN `Portfolio-3`.`Teams_has_Escape Rooms` ON Teams.TeamID = `Teams_has_Escape Rooms`.TeamID
JOIN `Portfolio-3`.`Escape Rooms` ON `Teams_has_Escape Rooms`.`Escape Rooms_RoomID` = `Escape Rooms`.RoomID
ORDER BY EscapeRoom, Teams.CompletionStatus;
