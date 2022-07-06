-- A crime has taken place and the detective needs your help. The detective gave you the crime scene report, but you somehow lost it. You vaguely remember that the crime was a ​murder​ that occurred sometime on ​Jan.15, 2018​ and that it took place in ​SQL City​. Start by retrieving the corresponding crime scene report from the police department’s database.

-- Run this query to find the structure of the `crime_scene_report` table
-- Change the value of 'name' to see the structure of the other tables you learned about with the previous query.

SELECT name 
FROM sqlite_master
where type = 'table'
-----
Table: name
crime_scene_report
drivers_license
person
facebook_event_checkin
interview
get_fit_now_member
get_fit_now_check_in
income
solution
-----

SELECT *
FROM crime_scene_report
WHERE date = 20180115 AND city = 'SQL City' AND Type = 'murder'

-- date	type description city
-- 20180115	murder	Security footage shows that there were 2 witnesses. The first witness lives at the last house on "Northwestern Dr". The second witness, named Annabel, lives somewhere on "Franklin Ave".	SQL City

SELECT * --FINDING WITNESS 1
FROM person 
WHERE address_street_name LIKE 'Northwestern DR'
ORDER BY address_number DESC LIMIT 1

-- id	name	license_id	address_number	address_street_name	ssn
-- 14887	Morty Schapiro	118009	4919	Northwestern Dr	111564949

SELECT * --FINDING MORTY SCHAPIRO'S INTERVIEW
FROM interview
WHERE person_id = 14887

-- person_id	transcript
-- 14887	I heard a gunshot and then saw a man run out. He had a "Get Fit Now Gym" bag. The membership number on the bag started with "48Z". Only gold members have those bags. The man got into a car with a plate that included "H42W".

SELECT *
FROM get_fit_now_member
WHERE id LIKE '48Z%' AND membership_status = 'gold'

-- id	person_id	name	membership_start_date	membership_status
-- 48Z38	49550	Tomas Baisley	20170203	silver
-- 48Z7A	28819	Joe Germuska	20160305	gold
-- 48Z55	67318	Jeremy Bowers	20160101	gold

SELECT * --FINDING THE CAR WITH LICENSE INCLUDING 'H42W'
FROM drivers_license
WHERE plate_number LIKE '%H42W%'

-- id	age	height	eye_color	hair_color	gender	plate_number	car_make	car_model
-- 183779	21	65	blue	blonde	female	H42W0X	Toyota	Prius
-- 423327	30	70	brown	brown	male	0H42W2	Chevrolet	Spark LS
-- 664760	21	71	black	black	male	4H42WR	Nissan	Altima

SELECT * --CHECKING THE DRIVER OF THE CARS
FROM person
WHERE license_id = 423327

-- id	name	license_id	address_number	address_street_name	ssn
-- 67318	Jeremy Bowers	423327	530	Washington Pl, Apt 3A	871539279


SELECT * --FINDING SECOND WITNESS
FROM person
WHERE name LIKE 'Annabel%' AND address_street_name = 'Franklin Ave'

-- id	name	license_id	address_number	address_street_name	ssn
-- 16371	Annabel Miller	490173	103	Franklin Ave	318771143

SELECT * --CHECKING ANNABEL'S INTERVIEW
FROM interview
WHERE person_id = 16371

-- person_id	transcript
-- 16371	I saw the murder happen, and I recognized the killer from my gym when I was working out last week on January the 9th.

SELECT * --LOOKING FOR ANNABEL'S GYM ID
FROM get_fit_now_member
WHERE name = 'Annabel Miller'

-- id	person_id	name	membership_start_date	membership_status
-- 90081	16371	Annabel Miller	20160208	gold

SELECT * --CHECKING WHEN SHE CHECKED IN AND OUT
FROM get_fit_now_check_in
WHERE membership_id = 90081
-- membership_id	check_in_date	check_in_time	check_out_time
-- 90081	20180109	1600	1700

SELECT * --CHECKING WHO WAS AT THE GYM WITH HER ON THAT DAY
FROM get_fit_now_check_in
WHERE check_in_date = 20180109 
AND check_in_time <= 1600 
AND check_out_time >= 1700

-- membership_id	check_in_date	check_in_time	check_out_time
-- 48Z7A	20180109	1600	1730
-- 48Z55	20180109	1530	1700 
-- 90081	20180109	1600	1700

SELECT * --FINDING THE MEMBER NAME
FROM get_fit_now_member
WHERE id = '48Z7A'

-- id	person_id	name	membership_start_date	membership_status
-- 48Z7A	28819	Joe Germuska	20160305	gold
SELECT * 
FROM person
WHERE name = 'Joe Germuska'

-- id	name	license_id	address_number	address_street_name	ssn
-- 28819	Joe Germuska	173289	111	Fisk Rd	138909730

SELECT * --CHECKING JOE'S INTERVIEW
FROM interview
WHERE person_id  = 67318
--NOTHING RETURNED - NO INTERVIEW CONDUCTED

SELECT * --FINDING THE MEMBER NAME
FROM get_fit_now_member
WHERE id = '48Z55'

-- id	person_id	name	membership_start_date	membership_status
-- 48Z55	67318	Jeremy Bowers	20160101	gold

SELECT * 
FROM person
WHERE name = 'Jeremy Bowers'

-- id	name	license_id	address_number	address_street_name	ssn
-- 67318	Jeremy Bowers	423327	530	Washington Pl, Apt 3A	871539279

SELECT * 
FROM interview
WHERE person_id  = 67318

-- person_id	transcript
-- 67318	I was hired by a woman with a lot of money. I don't know her name but I know she's around 5'5" (65") or 5'7" (67"). She has red hair and she drives a Tesla Model S. I know that she attended the SQL Symphony Concert 3 times in December 2017.

SELECT * --FINDING WHO HIRED JEREMY
FROM drivers_license
WHERE height BETWEEN 65 AND 67 
AND hair_color = 'red'
AND gender = 'female'
AND car_make = 'Tesla'
AND car_model = 'Model S'

-- id	age	height	eye_color	hair_color	gender	plate_number	car_make	car_model
-- 202298	68	66	green	red	female	500123	Tesla	Model S
-- 291182	65	66	blue	red	female	08CM64	Tesla	Model S
-- 918773	48	65	black	red	female	917UU3	Tesla	Model S

SELECT *  --CHECKING WHO ATTENDED THE EVENT 3 TIMES ON THIS DATE
FROM facebook_event_checkin
WHERE event_name like 'SQL Symphony Concert'
AND date BETWEEN 20171201 AND 20171231
ORDER BY person_id

-- 99716	1143	SQL Symphony Concert	20171206
-- 99716	1143	SQL Symphony Concert	20171212
-- 99716	1143	SQL Symphony Concert	20171229

SELECT * --FINDING NAME OF PERSON WITH ID 99716
FROM person
WHERE id = 99716

-- id	name	license_id	address_number	address_street_name	ssn
-- 99716	Miranda Priestly	202298	1883	Golden Ave	987756388

SELECT * --CHECKING TO SEE IF MIRANDA PRIESTLY MAKES ALOT OF MONEY
FROM income
WHERE annual_income > --SEEING IF HER INCOME IS ABOVE AVERAGE
(
  SELECT AVG(annual_income) AS avg_income  --SUBQUERY TO CALCULATE THE AVERAGE INCOME
FROM income
)
AND ssn = 987756388

-- ssn	annual_income
-- 987756388	310000



-- Check your solution
-- Did you find the killer?
INSERT INTO solution VALUES (1, 'Jeremy Bowers');
        SELECT value FROM solution;

-- value
-- Congrats, you found the murderer! But wait, there's more... If you think you're up for a challenge, try querying the interview transcript of the murderer to find the real villain behind this crime. If you feel especially confident in your SQL skills, try to complete this final step with no more than 2 queries. Use this same INSERT statement with your new suspect to check your answer.

INSERT INTO solution VALUES (1, 'Miranda Priestly');
        SELECT value FROM solution;

-- value
-- Congrats, you found the brains behind the murder! Everyone in SQL City hails you as the greatest SQL detective of all time. Time to break out the champagne!
