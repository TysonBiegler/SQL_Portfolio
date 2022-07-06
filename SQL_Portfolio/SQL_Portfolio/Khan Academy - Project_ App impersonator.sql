--Think about your favorite apps, and pick one that stores your data- like a game that stores scores, an app that lets you post updates, etc. Now in this project, you're going to imagine that the app stores your data in a SQL database (which is pretty likely!), and write SQL statements that might look like their own SQL.

CREATE TABLE twitter (
ID INTEGER PRIMARY KEY,
User_Name TEXT,
First_Name TEXT,
Last_Name TEXT,
Content TEXT,
Date TEXT
);

INSERT INTO twitter (User_Name, First_Name, Last_Name, Content, Date)
VALUES ('myspace_tom', 'Tom', 'Anderson', 'How do I update my profile song?', '3/5/2022');

INSERT INTO twitter (User_Name, First_Name, Last_Name, Content, Date)
VALUES ('meta_mark', 'Mark', 'Zuckerberg', 'Changing the name of Facebook to Meta', '3/7/2022');

INSERT INTO twitter (User_Name, First_Name, Last_Name, Content, Date)
VALUES ('doge_father', 'Elon', 'Musk', 'Definitly not a flamethrower.', '3/15/2022');

INSERT INTO twitter (User_Name, First_Name, Last_Name, Content, Date)
VALUES ('my_names_jeff', 'Jeff', 'Bezos', 'Note to self: Beat the doge_father to Mars!', '3/18/2022');

SELECT * FROM twitter;

UPDATE twitter
SET Content = 'Should I get into the rocket business too?' 
WHERE id = 2;

SELECT * FROM twitter;

DELETE FROM twitter 
WHERE id = 1;

SELECT * FROM twitter;
