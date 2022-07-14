/********************************************Referee******************************************/
/* INSERT*/
INSERT INTO Referee VALUES (5, 'Yaron', 'Meter');
INSERT INTO Referee VALUES (6, 'Sagie', 'Berman');

/* UPDATE*/
UPDATE Referee
SET first_name = 'Sapir'
WHERE ID = 6;

/* DELETE*/
DROP PROCEDURE IF EXISTS deleteReferee;
DELIMITER //
CREATE PROCEDURE deleteReferee(IN refID INT(11))
BEGIN
	DELETE FROM referee WHERE ID = refID;
END //
DELIMITER ; 

CALL deleteReferee(5);
CALL deleteReferee(6);