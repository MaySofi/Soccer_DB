/***************************************Stadium***************************************/

SELECT * FROM Stadium;
INSERT INTO stadium (stadium_id, stadium_name, capacity, city, address)
SELECT MAX(stadium_id)+1, 'Teddi', 34000, 'Jerusalem', 'Dereh agudat sport' FROM stadium;
INSERT INTO stadium (stadium_id, stadium_name, capacity, city, address)
SELECT MAX(stadium_id)+1, 'Wembley', 89874, 'London', 'Wembley park' FROM stadium;

DROP PROCEDURE IF EXISTS updateStad;
DELIMITER //
CREATE PROCEDURE updateStad(IN stadID INT(11),cap INT(11))
BEGIN
	UPDATE Stadium
	SET capacity = cap
	WHERE stadium_id = stadID;
END //

CALL updateStad(9,2);

/* DELETE*/
DROP PROCEDURE IF EXISTS deleteStadium;
DELIMITER //
CREATE PROCEDURE deleteStadium(IN stadID INT(11))
BEGIN
	DELETE FROM Stadium WHERE stadium_id = stadID;
END //
DELIMITER ; 

CALL deleteStadium(9);