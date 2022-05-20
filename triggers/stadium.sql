DROP TABLE IF EXISTS stadium_log;

/************************************STADIUM************************************/

CREATE TABLE stadium_LOG (
	stadium_id INT NOT NULL,
	stadium_name VARCHAR(45) NOT NULL,
	capacity INT NOT NULL,
	city VARCHAR(45) NOT NULL,
	address VARCHAR(45) NOT NULL,command_ts timestamp,
	command varchar(10)
);

DROP TRIGGER IF EXISTS insert_stadium;
delimiter $
CREATE TRIGGER insert_stadium AFTER INSERT ON stadium
FOR EACH ROW
BEGIN
	INSERT INTO stadium_LOG
	VALUES
	(
		NEW.stadium_id,
		NEW.stadium_name,
		NEW.capacity,
		NEW.city,
		NEW.address,
		now(),
		'Inserted'
	);
END$
delimiter;

DROP TRIGGER IF EXISTS update_stadium;

delimiter $
CREATE TRIGGER update_stadium AFTER UPDATE ON stadium
FOR EACH ROW
BEGIN
	INSERT INTO stadium_LOG
	VALUES
	(
		NEW.stadium_id,
		NEW.stadium_name,
		NEW.capacity,
		NEW.city,
		NEW.address,
		now(),
		'Updated'
	);
END$
delimiter;

DROP TRIGGER IF EXISTS delete_stadium;

delimiter $
CREATE TRIGGER delete_stadium AFTER DELETE ON stadium
FOR EACH ROW
BEGIN
	INSERT INTO stadium_LOG
	VALUES
	(
		OLD.stadium_id,
		OLD.stadium_name,
		OLD.capacity,
		OLD.city,
		OLD.address,
		now(),
		'Deleted'
	);
END$
delimiter;