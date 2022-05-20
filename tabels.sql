CREATE SCHEMA IF NOT EXISTS soccer_DB;
USE soccer_DB;

-- -----------------------------------------------------
-- Table soccer_DB.league
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS soccer_DB.league (
  league_id INT NOT NULL,
  league_name VARCHAR(45) NOT NULL,
  start_date DATE NOT NULL,
  end_date DATE NOT NULL,
  PRIMARY KEY (league_id));


-- -----------------------------------------------------
-- Table soccer_DB.stadium
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS soccer_DB.stadium (
  stadium_id INT NOT NULL AUTO_INCREMENT,
  stadium_name VARCHAR(45) NOT NULL,
  capacity INT NOT NULL,
  city VARCHAR(45) NOT NULL,
  address VARCHAR(45) NOT NULL,
  PRIMARY KEY (stadium_id));


-- -----------------------------------------------------
-- Table soccer_DB.team
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS soccer_DB.team (
  team_id INT NOT NULL AUTO_INCREMENT,
  team_name VARCHAR(45) NOT NULL,
  League_league_id INT NOT NULL,
  Stadium_stadium_id INT NOT NULL,
  PRIMARY KEY (team_id, League_league_id, Stadium_stadium_id),
  INDEX fk_Team_League_idx (League_league_id ASC) VISIBLE,
  INDEX fk_Team_Stadium1_idx (Stadium_stadium_id ASC) VISIBLE,
  CONSTRAINT fk_Team_League
    FOREIGN KEY (League_league_id)
    REFERENCES soccer_DB.league (league_id),
  CONSTRAINT fk_Team_Stadium1
    FOREIGN KEY (Stadium_stadium_id)
    REFERENCES soccer_DB.stadium (stadium_id));


-- -----------------------------------------------------
-- Table soccer_DB.fan_club
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS soccer_DB.fan_club (
  fan_club_id INT NOT NULL AUTO_INCREMENT,
  name VARCHAR(45) NOT NULL,
  Team_team_id INT NOT NULL,
  PRIMARY KEY (fan_club_id, Team_team_id),
  INDEX fk_fan_Club_Team1_idx (Team_team_id ASC) VISIBLE,
  CONSTRAINT fk_fan_Club_Team1
    FOREIGN KEY (Team_team_id)
    REFERENCES soccer_DB.team (team_id));


-- -----------------------------------------------------
-- Table soccer_DB.fan
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS soccer_DB.fan (
  fan_id INT NOT NULL AUTO_INCREMENT,
  first_name VARCHAR(45) NOT NULL,
  last_name VARCHAR(45) NOT NULL,
  birthdate DATE NOT NULL,
  fan_Club_fan_club_id INT NOT NULL,
  PRIMARY KEY (fan_id, fan_Club_fan_club_id),
  INDEX fk_Fan_fan Club1_id (fan_Club_fan_club_id ASC) VISIBLE,
  CONSTRAINT fk_Fan_fan Club1
    FOREIGN KEY (fan_Club_fan_club_id)
    REFERENCES soccer_DB.fan_club (fan_club_id));


-- -----------------------------------------------------
-- Table soccer_DB.game
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS soccer_DB.game (
  game_id INT NOT NULL AUTO_INCREMENT,
  game_date DATE NOT NULL,
  home_team_score INT ,
  away_team_score INT ,
  host_team INT NOT NULL,
  away_team INT NOT NULL,
  PRIMARY KEY (game_id, host_team, away_team),
  INDEX fk_Game_Team1_idx (host_team ASC) VISIBLE,
  INDEX fk_Game_Team2_idx (away_team ASC) VISIBLE,
  CONSTRAINT fk_Game_Team1
    FOREIGN KEY (host_team)
    REFERENCES soccer_DB.team (team_id),
  CONSTRAINT fk_Game_Team2
    FOREIGN KEY (away_team)
    REFERENCES soccer_DB.team (team_id));


-- -----------------------------------------------------
-- Table soccer_DB.referee
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS soccer_DB.referee (
  ID INT NOT NULL,
  first_name VARCHAR(45) NOT NULL,
  last_name VARCHAR(45) NOT NULL,
  PRIMARY KEY (ID));


-- -----------------------------------------------------
-- Table soccer_DB.game_has_referee
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS soccer_DB.game_has_referee (
  game_game_id INT NOT NULL,
  referee_ID INT NOT NULL,
  INDEX fk_game_has_referee_referee1_idx (referee_ID ASC) VISIBLE,
  INDEX fk_game_has_referee_game1_idx (game_game_id ASC) VISIBLE,
  CONSTRAINT fk_game_has_referee_game1
    FOREIGN KEY (game_game_id)
    REFERENCES soccer_DB.game (game_id),
  CONSTRAINT fk_game_has_referee_referee1
    FOREIGN KEY (referee_ID)
    REFERENCES soccer_DB.referee (ID));


-- -----------------------------------------------------
-- Table soccer_DB.player
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS soccer_DB.player (
  player_id INT NOT NULL AUTO_INCREMENT,
  first_name VARCHAR(45) NOT NULL,
  last_name VARCHAR(45) NOT NULL,
  birthday DATE NOT NULL,
  shirt_number VARCHAR(45) NOT NULL,
  position VARCHAR(45) NOT NULL,
  salary INT NOT NULL,
  Team_team_id INT NOT NULL,
  goals INT NOT NULL,
  yellow_cards INT NOT NULL,
  red_cards INT NOT NULL,
  PRIMARY KEY (player_id, Team_team_id),
  INDEX fk_Player_Team1_id (Team_team_id ASC) VISIBLE,
  CONSTRAINT fk_Player_Team1
    FOREIGN KEY (Team_team_id)
    REFERENCES soccer_DB.team (team_id));


-- -----------------------------------------------------
-- Table soccer_DB.stuff
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS soccer_DB.stuff (
  stuff_id INT NOT NULL AUTO_INCREMENT,
  first_name VARCHAR(45) NOT NULL,
  last_name VARCHAR(45) NOT NULL,
  role VARCHAR(45) NOT NULL,
  birthday DATE NOT NULL,
  salary INT NOT NULL,
  Seniority INT NOT NULL,
  Team_team_id INT NOT NULL,
  PRIMARY KEY (stuff_id, Team_team_id),
  INDEX fk_Stuff_Team1_idx (Team_team_id ASC) VISIBLE,
  CONSTRAINT fk_Stuff_Team1
    FOREIGN KEY (Team_team_id)
    REFERENCES soccer_DB.team (team_id));


-- -----------------------------------------------------
-- Table soccer_DB.ticket
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS soccer_DB.ticket (
  Ticket_id INT NOT NULL,
  ticket_price VARCHAR(45) NOT NULL,
  game_game_id INT NOT NULL,
  fan_fan_id INT NOT NULL,
  PRIMARY KEY (Ticket_id, game_game_id, fan_fan_id),
  UNIQUE INDEX Ticket_id_UNIQUE (Ticket_id ASC) VISIBLE,
  INDEX fk_Ticket_game1_idx (game_game_id ASC) VISIBLE,
  INDEX fk_Ticket_fan1_idx (fan_fan_id ASC) VISIBLE,
  CONSTRAINT fk_Ticket_fan1
    FOREIGN KEY (fan_fan_id)
    REFERENCES soccer_DB.fan (fan_id),
  CONSTRAINT fk_Ticket_game1
    FOREIGN KEY (game_game_id)
    REFERENCES soccer_DB.game (game_id));	