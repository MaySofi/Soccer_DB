/*****************************************MANAGER******************************************/
#1
DROP PROCEDURE IF EXISTS check_player_age_oldest;
DELIMITER //
CREATE PROCEDURE check_player_age_oldest()
BEGIN
	SELECT (YEAR(CURRENT_TIMESTAMP) - MIN(YEAR(birthday))) AS age
	FROM player;
END //
DELIMITER ;

CALL check_player_age_oldest();


#2
DROP PROCEDURE IF EXISTS check_player_age_youngest;
DELIMITER //
CREATE PROCEDURE check_player_age_youngest()
BEGIN
	SELECT (year(CURRENT_TIMESTAMP) - MAX(year(birthday))) AS age
	FROM player;
END //
DELIMITER ;

CALL check_player_age_youngest();


#3
DROP PROCEDURE IF EXISTS count_goals_of_each_team;
DELIMITER //
CREATE PROCEDURE count_goals_of_each_team()
BEGIN
	SELECT
		team.team_name,
		SUM(player.goals) AS total_goals
	FROM team, player
	WHERE player.Team_team_id = team.team_id
	GROUP BY team.team_id;
END //
DELIMITER ;

CALL count_goals_of_each_team();


#4
DROP PROCEDURE IF EXISTS count_out_goals_of_each_team;
DELIMITER //
CREATE PROCEDURE count_out_goals_of_each_team()
BEGIN
	SELECT
		team.team_name,
		SUM(game.away_team_score) AS total_out_goals
	FROM team, game
	WHERE game.away_team = team.team_id
	GROUP BY team.team_id;
END //
DELIMITER ;

CALL count_out_goals_of_each_team();


#5
DROP PROCEDURE IF EXISTS count_in_goals_of_each_team;
DELIMITER //
CREATE PROCEDURE count_in_goals_of_each_team()
BEGIN
	SELECT
		team.team_name,
		SUM(game.home_team_score) AS total_in_goals
	FROM team, game
	WHERE game.host_team = team.team_id
	GROUP BY team.team_id;
END //
DELIMITER ;

CALL count_in_goals_of_each_team();


#6
DROP PROCEDURE IF EXISTS count_salary_sum;
DELIMITER //
CREATE PROCEDURE count_salary_sum()
BEGIN
	SELECT SUM(player.salary) AS total_salaries
	FROM player;
END //
DELIMITER ;

CALL count_salary_sum();


#7
DROP PROCEDURE IF EXISTS check_stuff_Seniority;
DELIMITER //
CREATE PROCEDURE check_stuff_Seniority()
BEGIN
	SELECT Seniority
	FROM stuff
	WHERE stuff_id =1;
END //
DELIMITER ;

CALL check_stuff_Seniority();


#8
DROP PROCEDURE IF EXISTS goals_of_the_opposing_team;
DELIMITER //
CREATE PROCEDURE goals_of_the_opposing_team()
BEGIN
	SELECT
		team.team_id,
		team.team_name,
		SUM
		(
			CASE
				WHEN
					team.team_id != game.away_team AND
					team.team_id = game.host_team 
				THEN game.away_team_score
				WHEN
					team.team_id = game.away_team AND
					team.team_id != game.host_team
				THEN game.home_team_score 
				ELSE 0 
			END
		) AS opposing_team_goals
	FROM game, team
	GROUP BY team.team_id
    ORDER BY team_id;
END //
DELIMITER ;

CALL goals_of_the_opposing_team();


#9
DROP PROCEDURE IF EXISTS average_age_per_group;
DELIMITER //
CREATE PROCEDURE average_age_per_group()
BEGIN
	SELECT
		tName AS Team,
		age_avg AS average_age
	FROM
	(
		SELECT
			AVG((YEAR(CURRENT_TIMESTAMP) - YEAR(player.birthday))) AS age_avg,
			team.team_name AS tName
		FROM player, team
		WHERE player.Team_team_id = team.team_id
		GROUP BY team.team_id
		ORDER BY age_avg DESC
	) t;
END //
DELIMITER ;

CALL average_age_per_group();


#10
DROP PROCEDURE IF EXISTS Length_of_Soccer_League_Season;
DELIMITER //
CREATE PROCEDURE Length_of_Soccer_League_Season()
BEGIN
	SELECT
		league.start_date,
		league.end_date,
		DATEDIFF(end_date, start_date) AS DayDiff
	FROM league
	ORDER BY league_id;
END //
DELIMITER ;

CALL Length_of_Soccer_League_Season();