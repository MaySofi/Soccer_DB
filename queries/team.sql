/******************************************Team******************************************/
SET FOREIGN_KEY_CHECKS = 0;
INSERT INTO Team VALUES (10, 'Beitar jerusalem', 1, 9);
INSERT INTO Team VALUES (11, 'Tottenham', 2, 10);
SET FOREIGN_KEY_CHECKS = 1;
 
SELECT *
FROM TEAM;
 
DROP PROCEDURE IF EXISTS updateStad;
DELIMITER //
CREATE PROCEDURE updateStad(IN teamID INT(11),stadID INT(11))
BEGIN
	UPDATE Team
	SET stadium_stadium_id = stadID
	WHERE team_id = teamID;
END //

CALL updateStad(10,2);

/* DELETE*/
DROP PROCEDURE IF EXISTS deleteTeam;
DELIMITER //
CREATE PROCEDURE deleteTeam(IN teamID INT(11))
BEGIN
	DELETE FROM Team WHERE team_id = teamID;
END //
DELIMITER ; 
 
CALL deleteTeam(11);