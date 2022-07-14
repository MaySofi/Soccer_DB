DROP TABLE IF EXISTS Referee_LOG;

/************************************REFEREE************************************/

 CREATE TABLE Referee_LOG (
	ID INT NOT NULL,
	first_name VARCHAR(45) NOT NULL,
	last_name  VARCHAR(45) NOT NULL,
	command_ts timestamp,
	command varchar(10)
);

DROP TRIGGER IF EXISTS insert_referee;
delimiter $
CREATE TRIGGER insert_referee AFTER INSERT ON Referee
FOR EACH ROW
BEGIN
	INSERT INTO Referee_LOG
	VALUES
	(
		NEW.ID,
		NEW.first_name,
		NEW.last_name,
		now(),
		'Inserted'
	);
END$
delimiter;

DROP TRIGGER IF EXISTS update_referee;
delimiter $
CREATE TRIGGER update_referee after update on Referee
FOR EACH ROW
BEGIN
	INSERT INTO Referee_LOG
	VALUES
	(
		NEW.ID,
		NEW.first_name,
		NEW.last_name,
		now(),
		'Updated'
	);
END$
delimiter;

DROP TRIGGER IF EXISTS delete_referee;
delimiter $
CREATE TRIGGER delete_referee AFTER DELETE ON Referee
FOR EACH ROW
BEGIN
	INSERT INTO Referee_LOG
	VALUES
	(
		OLD.ID,
		OLD.first_name,
		OLD.last_name,
		now(),
		'Deleted'
	);
END$
delimiter;