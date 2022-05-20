 /** *****************************************************************************************/
 /** ************************************** INSERT********************************************/
 /** *****************************************************************************************/
 
SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE TABLE League;
TRUNCATE TABLE Stadium;
TRUNCATE TABLE Team;
TRUNCATE TABLE Game;
TRUNCATE TABLE Fan_Club;
TRUNCATE TABLE fan;
TRUNCATE TABLE player;
TRUNCATE TABLE Stuff;
TRUNCATE TABLE Ticket;
TRUNCATE TABLE Referee;
TRUNCATE TABLE game_has_referee;
SET FOREIGN_KEY_CHECKS = 1;

 
INSERT  INTO League (league_id, league_name, start_date, end_date)
VALUES 	(1, 'Israeli League',Date '2022-09-01', Date '2023-05-30' ),
		(2, 'English Premier League',Date '2022-09-10', Date '2023-06-05');

INSERT  INTO Stadium (stadium_id,stadium_name, capacity, city, address)
VALUES	(1,'Bloomflield Stadium', 29400, 'Tel Aviv','Ha-Tkuma 1'),
		(2,'Sami Ofer', 30780, 'Haifa','Pinkhas ve-Avraham Rutenberg 2'),
		(3,'Terner', 16126, 'Beersheba','Etsel 6'),
		(4,'HaMoshava', 11500, 'Petah Tikva','Shlomo Shmeltzer 12'),
		(5,'Etihad', 55097, 'Manchester', 'Ashton New Rd'),
		(6,'Old Trafford', 74140, 'Manchester', ' Sir Matt Busby Way'),
		(7,'Stamford Bridge', 41837, 'London', 'Fulham Rd'),
		(8,'Emirates Stadium', 60260, 'London', 'Hornsey Rd');

INSERT  INTO Referee(ID, first_name , last_name)
VALUES 
		(1, 'Eitan', 'Shmuelevitz'),
		(2, 'Erez', 'Papir'),
		(3, 'Liran', 'Liani'),
		(4, 'Orel', 'Gringeld');

INSERT  INTO Team (team_id,team_name, League_league_id, Stadium_stadium_id)
VALUES 
		(1,'Hapoel Tel Aviv', 1,1),
		(2,'Maccabi Haifa', 1, 2),
		(3,'Hapoel Beer Sheva', 1, 3),
		(4,'Maccabi Petah Tikva', 1,4),
		(5,'Maccabi Tel Aviv', 1,1),
		(6,'Manchester City', 2,5),
		(7,'Manchester United', 2, 6),
		(8,'Chelsea', 2, 7),
		(9,'Arsenal', 2, 8);

INSERT  INTO Game (game_id,game_date, home_team_score, away_team_score, host_team,  away_team )
VALUES 
		(1, '2022-09-01', 3, 1, 1,2),
		(2, '2022-09-01', 3, 2, 3,4),
		(3, '2022-09-08', 0, 2, 5,1),
		(4, '2022-09-08', 1, 4, 2,3),
		(5, '2022-09-15', 3, 0, 1,4),
		(6, '2022-09-15', 2, 2, 2,5),
		(7, '2022-10-22', 2, 3, 3,1),
		(8, '2022-10-22', 1, 1, 4,2),	
		(9, '2022-09-10', 2, 4, 6, 7),
		(10, '2022-09-10', 1, 1, 8, 9),
		(11, '2022-09-17', 2, 0, 9, 6),
		(12, '2022-09-17', 4, 4, 7, 8),
		(13, '2022-09-24', 1, 0, 6, 8),
		(14, '2022-10-24', 1, 2, 7, 9);
		

INSERT  INTO Fan_Club(fan_club_id, name, Team_team_id)
VALUES 
		(1,'Ultras Hapoel', 1),
		(2,'Green Apes', 2),
		(3,'UltraSouth', 3),
		(4,'Maccabi Petah Tikva Ultras', 4),
		(5,'Maccabi Fanatics', 5),
		(6,'Man City Ultras', 6),
		(7,'Red Army', 7),
		(8,'Chelsea Headhunters', 8),
		(9,'Arsenal firm', 9);


INSERT  INTO Fan(fan_id,first_name,last_name, birthdate,fan_Club_fan_club_id)
VALUES 
		(1,'Yossi', 'Meir','1972-06-04',3),
		(2,'Maya','Levi','1972-05-01',1),
		(3,'Dani','Mizrahi','2003-02-07',2),
		(4,'Tali','Cohen','1965-03-08',2),
		(5,'Eli','Zohar','1981-01-15',3),
		(6,'David','Cohen','1979-01-2',3),
		(7,'Dan','Segal','2000-11-25',4),
		(8,'Maya','Levi','1995-10-19',4),
		(9,'John','Swift','2001-09-17',5),
		(10,'Megan','Jo','1979-08-06',5),  
		(11,'Eric','Young','1992-09-01',6),
		(12,'Vincent','Mata','1960-08-04',6),
		(13,'David','Cohen','1977-07-12',7),
		(14,'Ali','Hamid','1993-05-19',7),
		(15,'Goerge','Owen','1982-06-22',8),
		(16,'Cris','Best','1979-12-21',8);
		
INSERT  INTO Player(player_id,first_name, last_name,birthday, shirt_number, position, salary, Team_team_id, goals, yellow_cards, red_cards )
VALUES 
		(1,'Arnast',	'Setkus',	Date '1986-02-01', 	1,	'Goalkeeper', 12000,1, 0,1,0),
		(2,'Edi', 'Gotliv',	Date '1993-05-31', 	3,	'defence', 25000,1, 2,2,0),
		(3,'Shlomi', 'Azulai',Date '1982-03-03',	8,'Midfielder', 10000,1, 3,2,1),
		(4,'Josh', 'Cohen',Date '1988-08-13',1,	'Goalkeeper', 25000,2, 0 ,1 ,0),
		(5,'Cheron', 'Sheri',Date '1991-09-24',10,'Midfielder', 40000,2, 12,1,0),
		(6,'Din', 'Daviv',Date '1990-01-11',21,	'Striker',	38000,2, 14,2,1),
		(7,'Omri', 'Glazer',	Date '1993-07-21',	1,	'Goalkeeper', 20000,3, 0,0,0),
		(8,'Eyad', 'Abu Abid',Date '1989-04-25',	5,'defence',18000,3, 2,3,2),
		(9,'Nikita', 'Rokavitzia',Date '1988-01-14',	7,'Striker',28000,	3, 7,1,0),
		(10,'Arik', 'Yanko',	Date '1987-06-15',	1,'Goalkeeper', 10000,4, 0,3,0),
		(11,'Dor', 'Alu',Date '1990-03-20',3,'defence',8000,4, 0,0,0),
		(12,'Ido', 'Shachar',Date '1996-01-30',8,'Midfielder', 15000,4, 1,3,1),
		(13,'Daniel','Peretz',Date '1995-11-03',	1,	'Goalkeeper', 25000,5, 0,0,0),
		(14,'Avi', 'Rikan',Date '1991-03-28',2,'Midfielder', 25000,	5,0,1,0),
		(15,'Shiran','Yeyni',Date '1989-03-13',7,'Midfielder', 20000,	5, 4,2,0),
		(16,'John',	'Stones',Date '1991-12-01',	4,'Goalkeeper', 100000,	6, 2,1,1),
		(17,'Kevin', 'De Breune',Date '1992-05-16',16,'Midfielder', 130000,6, 10,0,2),
		(18,'Rahim', 'Sterling',	Date '1992-04-15',	7,'Striker',130000,	6, 11,1,1),
		(19,'David',	'De Gea',Date '1992-04-23',	1,'Goalkeeper', 120000,	7, 0,3,2),
		(20,'Paul', 'Pogba',Date '1990-06-12',16,'Midfielder', 110000,7, 5,1,1),
		(21,'Cristiano',	'Ronaldo',		Date '1986-01-17',7,'Striker',	140000,	7, 9,4,0),
		(22,'David','Azpilicuta',Date '1988-08-09',1,'defence',110000,8, 3,2,1),
		(23,'Ngolo', 'Kante',Date '1989-02-11',8,'Midfielder', 150000,8, 2,1,2),
		(24,'Kai','Havertz',Date '1994-07-02',11,'Striker',120000,	8, 8,3,2),
		(25,'Bernard','Leno',Date '1989-04-30',1,'Goalkeeper', 80000,9, 0,1,1),
		(26,'Bokaio','Saka',Date '1993-04-14',7,'Midfielder', 90000,	9, 6,0,0),
		(27,'Alexander','Lacazet',Date '1992-02-09',9,'Striker',	70000,9, 9,0,0);
	 

INSERT  INTO Stuff(stuff_id,first_name,last_name,role,birthday,Salary,Seniority, Team_team_id)
VALUES 
		(1,'Kobi','Refua','Coach',Date '1973-12-05', 10000, 12,1),
		(2,'Salim','Toama','Assitant Coach',	Date '1981-11-06',8000, 4, 1),
		(3,'Barak','Bachar','Coach',	Date '1979-04-13',15000, 8, 2),
		(4,'Guy','Tzarfati','Assitant Coach',Date '1978-12-14',13000, 4, 2),
		(5,'Elyaniv','Barda','Coach',Date '1981-01-01',9000, 1, 3),
		(6,'Alona','Barkat','Owner',	Date '1968-11-11',15000, 10, 3),
		(7,'Omer','Golan','Coach',Date '1983-05-19', 7000, 1, 4),
		(8,'Ami','Genish','Goalkeeper Coach',Date '978-12-14', 4000, 20, 4),
		(9,'Barak','Itzhaki','General Manager',Date '1981-12-11', 18000, 7,5),
		(10,'Mich','Goldhar','Owner',Date '1961-08-16',15000, 10, 5),
		(11,'Pep','Guradiola','Coach',Date '1981-12-11',60000, 15, 6),
		(12,'Juanma','Lillo','Assitant Coach',Date '1967-01-02',30000, 8, 6),
		(13,'Avram','Glazer','Owner',Date '1960-10-19',30000, 25, 7),
		(14,'Paolo ','Gaudino','Fitness Coach',Date '1972-09-12',25000, 16, 7),
		(15,'Thomas','Tuchel','Coach',Date '1973-08-19',45000, 18, 8),
		(16,'Zsolt',	'Low','Assitant Coach',	Date '1972-11-17', 15,35000, 8),
		(17,'Mikel','Arteta','Coach',Date '1982-03-26', 7, 35000, 9),
		(18,'Stan','Kroenke','Owner',Date '1947-07-29',12000, 31, 9);
		

		
INSERT  INTO Ticket(Ticket_id, ticket_price , game_game_id,fan_fan_id)
VALUES 
		(1, 100, 1, 1),
		(2, 100, 1, 2),
		(3, 80, 2, 3),
		(4, 90, 3, 4),
		(5, 90, 3, 5),
		(6, 90, 3, 6),
		(7, 100, 5, 1 ),
		(8, 100, 5, 2 ),
		(9, 100, 5, 3 ),
		(10, 100, 7, 10 ),
		(11, 100, 7, 11 ),
		(12, 100, 7, 12 ),
		(13, 100, 8, 13 ),
		(14, 100, 8, 14 ),
		(15, 100, 9, 11 ),
		(16, 100, 8, 15 );
		
INSERT  INTO game_has_referee(game_game_id, referee_ID)
VALUES
		(1,1),
		(1,2),
		(2,3),
		(3,4),
		(3,1),
		(4,2),
		(5,1),
		(5,2),
		(5,3),
		(6,4),
		(7,1),
		(8,2),
		(9,3),
		(9,4),
		(10,1),
		(11,2),
		(12,3),
		(13,4),
		(14,1);