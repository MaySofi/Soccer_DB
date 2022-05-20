DROP TABLE IF EXISTS Team_log;

/************************************TEAM************************************/

 CREATE TABLE Team_LOG (
	team_id INT NOT NULL,
	team_name VARCHAR(45) NOT NULL,
	League_league_id INT NOT NULL,
	Stadium_stadium_id INT NOT NULL,
	command_ts timestamp,
	command varchar(10)
);

DROP TRIGGER IF EXISTS insert_team;
delimiter $
CREATE TRIGGER insert_team AFTER INSERT ON Team
FOR EACH ROW
BEGIN
	INSERT INTO Team_LOG
	VALUES
	(
		NEW.team_id,
		NEW.team_name,
		NEW.League_league_id,
		NEW.Stadium_stadium_id,
		now(),
		'Inserted'
	);
END$
delimiter;

DROP TRIGGER IF EXISTS update_team;
delimiter $
CREATE TRIGGER update_team after update on Team
FOR EACH ROW
BEGIN
	INSERT INTO Team_LOG
	VALUES
	(
		NEW.team_id,
		NEW.team_name,
		NEW.League_league_id,
		NEW.Stadium_stadium_id,
		now(),
		'Updated'
	);
END$
delimiter;

DROP TRIGGER IF EXISTS delete_team;
delimiter $
CREATE TRIGGER delete_team AFTER DELETE ON Team
FOR EACH ROW
BEGIN
	INSERT INTO Team_LOG
	VALUES
	(
		OLD.team_id,
		OLD.team_name,
		OLD.League_league_id,
		OLD.Stadium_stadium_id,
		now(),
		'Deleted'
	);
END$
delimiter;