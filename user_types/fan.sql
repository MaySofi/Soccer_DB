/*****************************************Fan******************************************/

/* (1) Show 3 future games for team*/
DROP PROCEDURE IF EXISTS showFutureGame;
DELIMITER //
CREATE PROCEDURE showFutureGame(IN teamId INT(11))
BEGIN
	SELECT
		game_id,
		game_date,
		team1.team_name AS away_team,
		team2.team_name AS host_team
	FROM
		game,
		team AS team1,
		team AS team2
	WHERE
		(team1.team_id=game.away_team AND team2.team_id=game.host_team) AND
		(game.away_team = teamId OR game.host_team = teamId) AND
		game_date > now()
	ORDER BY game_date ASC
	LIMIT 3;
END //
DELIMITER ;

CALL showFutureGame(1);


/* (2) Show all the games that my team won*/
DROP PROCEDURE IF EXISTS showTeamWons;
DELIMITER //
CREATE PROCEDURE showTeamWons(IN teamId INT(11))
BEGIN
	SELECT
		game_id, winner.team_name AS winner,
		CONCAT(home_team_score,'-',away_team_score) AS score,
		loser.team_name AS loser
	FROM game, team winner, team loser
	WHERE
	(
		(game.away_team = teamId) AND
		game.home_team_score < game.away_team_score AND
		winner.team_id = game.away_team AND
		game.host_team = loser.team_id
	)
	OR
	(
		game.host_team = teamId AND
		game.home_team_score > game.away_team_score AND
		winner.team_id = game.host_team AND
		game.away_team = loser.team_id
	)
	GROUP BY game_id;
END //
DELIMITER ;

CALL showTeamWons(1);


/* (3) Show the game with the most goals*/
DROP PROCEDURE IF EXISTS mostGoals;
DELIMITER //
CREATE PROCEDURE mostGoals()
BEGIN
	SELECT
		game_id,
		game_date,
		teamA.team_name AS team1,
		CONCAT(home_team_score,'-',away_team_score) AS score,
		teamB.team_name AS team2,
		(game.home_team_score + game.away_team_score) AS total_goals
	FROM game, team teamA, team teamB
	GROUP BY game_id
	ORDER BY total_goals DESC
	LIMIT 1;
END //
DELIMITER ;

CALL mostGoals();


/* (4) Shows the fan with the most visited*/
DROP PROCEDURE IF EXISTS bestFan;
DELIMITER //
CREATE PROCEDURE bestFan()
BEGIN
	SELECT fan.*, MAX(c) AS games
	FROM
		(
			SELECT
				COUNT(*) AS c
			FROM ticket
			GROUP BY fan_fan_id
		)AS m,
		fan,
		game,
		ticket
	GROUP BY(fan.fan_id);
END //
DELIMITER ;

CALL bestFan();


/* (5) Show games that I visited*/
DROP PROCEDURE IF EXISTS homeWon;
DELIMITER //
CREATE PROCEDURE homeWon(in fanID INT(11))
BEGIN
	SELECT game_game_id,game_date,ticket_price
	FROM game, ticket
	WHERE ticket.fan_fan_id=fanID
	GROUP BY ticket_id;
END //

CALL homeWon(3);


/* (6) game with the max difference between goals*/
DROP PROCEDURE IF EXISTS deffGoals;
DELIMITER //
CREATE PROCEDURE deffGoals()
BEGIN
	SELECT
		game.*,
		abs(game.home_team_score-game.away_team_score) AS diff
	FROM game
	GROUP BY game_id
	ORDER BY diff desc
	LIMIT 1;
END //

CALL deffGoals();


/* (7) Check if there are players with my age*/
DROP PROCEDURE IF EXISTS checkAge;
DELIMITER //
CREATE PROCEDURE checkAge(in fanID INT(11))
BEGIN
	SELECT
		player_id,
		CONCAT(player.first_name, ' ',player.last_name) AS player_name,
		fan_id,
		CONCAT(fan.first_name, ' ',fan.last_name) AS fan_name,
		year(fan.birthdate) AS birth_year
	FROM player,fan
	WHERE 
		fan_id = fanID AND
		year(fan.birthdate) = year(player.birthday);
END //

CALL checkAge(14);


/* (8) Check how much tickets left for a game*/
DROP PROCEDURE IF EXISTS checkTickets;
DELIMITER //
CREATE PROCEDURE checkTickets(in gameID INT(11))
BEGIN
	SET @stadium_capacity =
	(
		SELECT capacity
		FROM game,stadium,team
		WHERE
			game.game_id = gameID AND
			game.host_team = team.team_id AND
			team.stadium_stadium_id = stadium.stadium_id
	);
	
	SET @num_of_tickets =
	(
		SELECT count(*) AS number_of_tickets
		FROM ticket
		WHERE ticket.game_game_id = gameID
		GROUP BY ticket.game_game_id
	);	
	
	SELECT
		stadium.stadium_name,
		@stadium_capacity-@num_of_tickets AS available_tickets
	FROM 
		stadium,
		ticket,
		game,
		team
	WHERE
		game.game_id = gameID AND
		game.host_team = team.team_id AND
		team.stadium_stadium_id = stadium.stadium_id
	LIMIT 1;
END //

CALL checkTickets(2);


/* (9) show the biggest fan club*/
DROP PROCEDURE IF EXISTS biggestFanClub;
DELIMITER //
CREATE PROCEDURE biggestFanClub()
BEGIN
	SELECT
		fan_club.name,
		fan.*
	FROM
		fan,
		fan_club,
		(
			SELECT
				fan_club_fan_club_id,
				COUNT(fan_id) AS maximumFans
			FROM fan
			GROUP BY(fan_club_fan_club_id)
			HAVING maximumFans =
			(
				SELECT MAX(numOfFans)
				FROM
				(
					SELECT COUNT(fan_id) AS numOfFans
					FROM fan
					GROUP BY(fan_club_fan_club_id)
				) AS maxFans
			)
		) AS bestClub
	WHERE
		fan.fan_club_fan_club_id = bestClub.fan_club_fan_club_id AND
		fan_club.fan_club_id = bestClub.fan_club_fan_club_id;
END //

CALL biggestFanClub();


/* (10) show the 3 best teams in the league*/

DROP FUNCTION IF EXISTS calcScore;
DELIMITER //
CREATE FUNCTION calcScore(myscore INT(11), othersScore INT(11))
RETURNS INT(11)
DETERMINISTIC
BEGIN
	DECLARE points INT(11);
	IF (myscore > othersScore) THEN
		SET points= 3;
	ELSE IF (myscore < othersScore) THEN
		SET points=0;
	ELSE 
		SET points= 1;
	END IF;
	RETURN (points);
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS showLeague;
DELIMITER //
CREATE PROCEDURE showLeague(leagueID INT(11))
BEGIN
	DROP TABLE IF EXISTS gamesPlusPoints;
	DROP TABLE IF EXISTS homeGamesPoints;
	DROP TABLE IF EXISTS awayGamesPoints;

	CREATE TABLE gamesPlusPoints
	SELECT
		DISTINCT game.*,
		calcScore(home_team_score,away_team_score) AS HOME,
		calcScore(away_team_score,home_team_score) AS AWAY
	FROM
		Game,
		team,
		league
	WHERE
		host_team = team_id AND
		league_league_id = leagueID;


	CREATE TABLE homeGamesPoints
	SELECT
		host_team,
		SUM(HOME) AS home_points,
		home_team_score,
		away_team_score,
		COUNT(game_id) AS games
	FROM gamesPlusPoints
	GROUP BY host_team;

	
	CREATE 	TABLE awayGamesPoints
	SELECT 
		away_team,
		SUM(AWAY) AS away_points,
		away_team_score,
		home_team_score,
		COUNT(game_id) AS games
	FROM gamesPlusPoints
	GROUP BY away_team;
	
	
	SELECT
		team_name,
		(homeGamesPoints.games+awayGamesPoints.games) AS Games,
		(homeGamesPoints.home_team_score + awayGamesPoints.away_team_score) AS 'For goals',
		(homeGamesPoints.away_team_score + awayGamesPoints.home_team_score) AS 'Against goals',
		(homeGamesPoints.home_team_score + awayGamesPoints.away_team_score -
			(homeGamesPoints.away_team_score + awayGamesPoints.home_team_score)) AS 'Goal Difference',
		(home_points+away_points) AS points

	FROM homeGamesPoints, awayGamesPoints,team
	WHERE
		homeGamesPoints.host_team = awayGamesPoints.away_team AND
		homeGamesPoints.host_team = team_id
	ORDER BY points DESC;
	
	DROP TABLE gamesPlusPoints;
	DROP TABLE homeGamesPoints;
	DROP TABLE awayGamesPoints;
	
END //
DELIMITER ;

CALL showLeague(1);