use euro;
-- 1. Write a SQL query to count the number of venues for the EURO cup 2016. Return the number of venues
SELECT COUNT(*) AS total_venues
FROM soccer_venue;
-- 2. Write a SQL query to count the number of countries that participated in the 2016-EURO Cup
SELECT COUNT(DISTINCT ï»¿team_id) AS total_countries
FROM soccer_team;
-- 3. Write a SQL query to find the number of goals scored within normal play during the EURO cup 2016
SELECT COUNT(DISTINCT ï»¿team_id) AS total_participating_countries
FROM soccer_team;
-- 4. Write a SQL query to find the number of matches that ended with a result
SELECT COUNT(*) AS matches_with_result
FROM match_mast
WHERE results = 'WIN';
-- 5. Write a SQL query to find the number of matches that ended in draws
SELECT COUNT(*) AS matches_drawn
FROM match_mast
WHERE results = 'DRAW';
-- 6. Write a SQL query to find out when the Football EURO cup 2016 will begin
SELECT country_name
FROM soccer_country a
JOIN soccer_city b ON a.ï»¿country_id = b.ï»¿city_id
JOIN soccer_venue c ON b.ï»¿city_id = c.ï»¿venue_id
LIMIT 0, 1000 ;
-- 7. Write a SQL query to find the number of self-goals scored during the 2016 European Championship
select count(*)
from goal_details
where goal_type ="O";
-- 8. Write a SQL query to count the number of matches that ended with results in-group stage.
select count(*)
from match_mast
where results ='WIN'
And play_stage = 'G';
-- 9. Write a SQL query to find the number of matches that resulted in a penalty shootout
select Count(Distinct match_no)
from penalty_shootout;
-- 10. Write a SQL query to find the number of matches decided by penalties in the Round 16.
select count(*)
from match_mast
where decided_by = 'p' and play_stage = 'R';
-- 11. Write a SQL query to find the number of goals scored in every match within a normal play schedule. Sort the result set on match number. Return the match number and, number of goal scored.
select match_no , count(*)
from goal_details 
Group by match_no
order by match_no;
-- 12. Write a SQL query to find the matches in which no stoppage time was added during the first half of play. Return the match no, date of play, and goal scored
select ï»¿match_no , play_date , goal_score
from match_mast
where stop1_sec = 0;
-- 13. Write a SQL query to count the number of matches that ended in a goalless draw at the group stage. Return the number of matches
select count(Distinct(ï»¿match_no))
from match_details
where win_lose ='D'
and goal_score =0
and play_stage ='G';
-- 14. Write a SQL query to calculate the number of matches that ended in a single goal win, excluding matches decided by penalty shootouts. Return the number of matches
select count(goal_score)
from match_details
where win_lose ='W'
and decided_by<> 'p'
and goal_score=1;
-- 15. Write a SQL query to count the number of players replaced in the tournament. Return the number of players as "Player Replaced"
select count(*) as "Player Replaced"
from player_in_out
where in_out ='I';
-- 16. Write a SQL query to find out where the final match of the European Cup 2016 was played. Return the venue name, city
select venue_name , city
from soccer_venue as a 
join soccer_city as b on a.city_id = b.ï»¿city_id
join match_mast as d on d.venue_id = a.ï»¿venue_id
and d.play_stage = 'F';
-- 17. Write a SQL query to find the number of goals scored by each team in each match during normal play. Return the match number, country name, and goal score
select ï»¿match_no , country_name , goal_score
from match_details as a 
join soccer_country as b on a.team_id = b.ï»¿country_id 
where decided_by = 'N'
order by ï»¿match_no;
-- 18. Write a SQL query to count the number of goals scored by each player within a normal play schedule. Group the result set by player name and country name, and sort the result from the highest to the lowest scorer. Return player name, number of goals, and country name
select player_name, count(*) as goal_count, country_name
from goal_details as a
join player_mast as b on a.player_id = b.ï»¿player_id
join soccer_country as c on a.team_id = c.ï»¿country_id
where goal_schedule ='NT'
Group by player_name, country_name
order by goal_count desc;
-- 19. Write a SQL query to find out who scored the most goals in the 2016 Euro Cup. Return player name, country name, and highest individual scorer
select player_name , country_name, count(player_name)
from goal_details as gd
join player_mast as pm on gd.player_id = pm.ï»¿player_id
join soccer_country sc on pm.team_id = sc.ï»¿country_id
Group by country_name , player_name
Having Count(player_name) >= ALL (
    select Count(player_name)
    From goal_details as gd
    join player_mast as pm on  gd.player_id = pm.ï»¿player_id
   join soccer_country as sc on pm.team_id = sc.ï»¿country_id
   Group by country_name , player_name 
);
-- 20. Write a SQL query to find out who scored in the final of the 2016 Euro Cup. Return player name, jersey number, and country name
SELECT 
    p.player_name,
    p.jersey_no,
    c.country_name
FROM 
    player_mast as p
JOIN 
    soccer_country as c ON p.team_id = c.ï»¿country_id;
-- 21. Write a SQL query to find out which country hosted the 2016 Football EURO Cup. Return the country name.
SELECT country_name 
FROM soccer_country 
WHERE ï»¿country_id=(
SELECT team_id 
FROM match_details 
WHERE play_stage='F' AND win_lose='L'
AND team_id<>(
SELECT ï»¿country_id
FROM soccer_country 
WHERE country_name='Portugal'));
-- 22. Write a SQL query to find out who scored the first goal of the 2016 European Championship. Return player_name, jersey_no, country_name, goal_time, play_stage, goal_schedule, goal_half
select a.player_name , a.jersey_no, b.country_name, c.goal_time, c.play_stage, c.goal_schedule , c.goal_half
from player_mast as a 
join soccer_country as b on a.team_id = b.ï»¿country_id
join goal_details as c on  c.player_id= a.ï»¿player_id
where ï»¿goal_id= 1;
-- 23. Write a SQL query to find the referee who managed the opening match. Return referee name, country name
select b.referee_mast, c.country_name
from match_mast as a 
Natural join referee_mast as b
natural join soccer_country as c
where ï»¿match_no = 1;
-- 24. Write a SQL query to find the referee who managed the final match. Return referee name, country name
select b.referee_name, c.country_name
from match_mast as a 
Natural join referee_mast as b
natural join soccer_country as c
where play_stage = 'F';
-- 25. Write a SQL query to find the referee who assisted the referee in the opening match. Return the associated referee name, country name.
select a.ass_ref_name , b.country_name
from asst_referee_mast as a 
join soccer_country as b on a.country_id =b.ï»¿country_id
join match_details as c on a.ï»¿ass_ref_id = c.ass_ref
where ï»¿match_no = 1;
-- 26. Write a SQL query to find the referee who assisted the referee in the final match. Return the associated referee name, country name
select a.ass_ref_name , b.country_name
from asst_referee_mast as a 
join soccer_country as b on a.country_id =b.ï»¿country_id
join match_details as c on a.ï»¿ass_ref_id = c.ass_ref
where play_stage = 'F';
-- 27. Write a SQL query to find the city where the opening match of the UEFA Euro 2016 took place. Return the venue name, city
select a.venue_name, b.city
from soccer_venue as a
join soccer_city as b on a.city_id = b.ï»¿city_id
join match_mast as c on a.ï»¿venue_id = c.venue_id
where ï»¿match_no = 1;
-- 28. Write a SQL query to find out which stadium hosted the final match of the 2016 Euro Cup. Return venue_name, city, aud_capacity, audience
select a.venue_name, b.city , a.aud_capacity, c.audence
from soccer_venue as a
join soccer_city as b on a.city_id = b.ï»¿city_id
join match_mast as c on a.ï»¿venue_id = c.venue_id
where play_stage = 'F';
-- 29. Write a SQL query to count the number of matches played at each venue. Sort the result set on venue name. Return Venue name, city,and number of matches
select a.venue_name, b.city , count(c.ï»¿match_no)
from soccer_venue as a
join soccer_city as b on a.city_id = b.ï»¿city_id
join match_mast as c on a.ï»¿venue_id = c.venue_id
Group by venue_name, city
order by venue_name;
-- 30. Write a SQL query to find the player who was the first player to be sent off at the EURO cup 2016. Return the match Number, country name, and player name.
select ï»¿match_no , country_name , player_name, booking_time as "sent_off_time" , play_schedule , jersey_no
from player_booked as a 
join player_mast as b on a.player_id =b.ï»¿player_id
join soccer_country as c on a.team_id = c.ï»¿country_id
and a.sent_off ='Y'
and ï»¿match_no = ( 
select MIN( ï»¿match_no)
from player_booked
)
order by ï»¿match_no, play_schedule , play_half, booking_time;
-- 31. Write a SQL query to find the teams that have scored one goal in the tournament. Return country_name as "Team", the team in the group, and goal_for


-- 32. Write a SQL query to count the number of yellow cards each country has received. Return the country name and number of yellow cards
select country_name, count(*)
from soccer_country
join player_booked
on soccer_country.ï»¿country_id = player_booked.team_id
Group by country_name
order by Count(*) Desc;
-- 33  Write a SQL query to count the number of goals that have been seen. Return the venue name and number of goals
