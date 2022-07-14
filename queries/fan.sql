/********************************************Fan******************************************/

/* INSERT*/
INSERT INTO Fan VALUES (17, 'Ofek', 'Rudich','1997-02-13',1);
INSERT INTO Fan VALUES (18, 'Roni','Bitan','1975-08-12',5);


/* UPDATE*/
UPDATE Fan SET fan_Club_fan_club_id = 2
WHERE fan_id=17;

UPDATE Fan SET fan_Club_fan_club_id = 1
WHERE fan_id=18;

/* DELETE*/
DROP PROCEDURE IF EXISTS deleteFan;

DELIMITER //
CREATE PROCEDURE deleteFan(IN fanID INT(11))
BEGIN
	DELETE FROM Fan WHERE fan_id = fanID;
END //
DELIMITER ; 

CALL deleteFan(17);
CALL deleteFan(18);