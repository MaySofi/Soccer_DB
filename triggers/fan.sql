DROP TABLE IF EXISTS fan_log;

/************************************FAN************************************/   
   
CREATE TABLE IF NOT EXISTS fan_LOG (
	fan_id INT NOT NULL,
	first_name VARCHAR(45) NOT NULL,
	last_name VARCHAR(45) NOT NULL,
	birthdate DATE NOT NULL,
	fan_Club_fan_club_id INT NOT NULL,
	command_ts timestamp,
	command varchar(10)
);

DROP TRIGGER IF EXISTS insert_fan;
delimiter $
CREATE TRIGGER insert_fan AFTER INSERT ON fan
FOR EACH ROW
BEGIN
	INSERT INTO fan_LOG
	VALUES
	(
		NEW.fan_id,
		NEW.first_name,
		NEW.last_name,
		NEW.birthdate,
		NEW.fan_Club_fan_club_id,
		now(),
		'Inserted'
	);
END$
delimiter;

DROP TRIGGER IF EXISTS update_fan;

delimiter $
CREATE TRIGGER update_fan after update on fan
FOR EACH ROW
BEGIN
	INSERT INTO fan_LOG
	VALUES
	(
		NEW.fan_id,
		NEW.first_name,
		NEW.last_name,
		NEW.birthdate,
		NEW.fan_Club_fan_club_id,
		now(),
		'Updated'
	);
END$
delimiter;

DROP TRIGGER IF EXISTS delete_fan;

delimiter $
CREATE TRIGGER delete_fan AFTER DELETE ON fan
FOR EACH ROW
BEGIN
	INSERT INTO fan_LOG
	VALUES
	(
		OLD.fan_id,
		OLD.first_name,
		OLD.last_name,
		OLD.birthdate,
		OLD.fan_Club_fan_club_id,
		now(),
		'Deleted'
	);
END$
delimiter;