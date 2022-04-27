--In this project I created a table of the US presidents and used the data to figure out how many total presidents, and percent of each party throughout history. 

CREATE TABLE presidents (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT,
    elected INTEGER,
    party TEXT);
    
INSERT INTO presidents (id, name, elected, party) VALUES (1, "George Washington", "1789", "Other");					
INSERT INTO presidents (id, name, elected, party) VALUES (2, "John Adams", "1797", "Other");					
INSERT INTO presidents (id, name, elected, party) VALUES (3, "Thomas Jefferson", "1801", "Other");					
INSERT INTO presidents (id, name, elected, party) VALUES (4, "James Madison", "1809", "Other");					
INSERT INTO presidents (id, name, elected, party) VALUES (5, "James Monroe", "1817", "Other");					
INSERT INTO presidents (id, name, elected, party) VALUES (6, "John Quincy Adams", "1825", "Other");					
INSERT INTO presidents (id, name, elected, party) VALUES (7, "AnOtherew jackson", "1829", "D");					
INSERT INTO presidents (id, name, elected, party) VALUES (8, "Martin Van Buren", "1837", "D");					
INSERT INTO presidents (id, name, elected, party) VALUES (9, "William Henry Harrison", "1841", "Other");					
INSERT INTO presidents (id, name, elected, party) VALUES (10, "John Tyler", "1841", "Other");					
INSERT INTO presidents (id, name, elected, party) VALUES (11, "James K. Polk", "1845", "D");					
INSERT INTO presidents (id, name, elected, party) VALUES (12, "Zachary Taylor", "1849", "Other");					
INSERT INTO presidents (id, name, elected, party) VALUES (13, "millard Filmore", "1850", "Other");					
INSERT INTO presidents (id, name, elected, party) VALUES (14, "Franklin Pierce", "1853", "D");					
INSERT INTO presidents (id, name, elected, party) VALUES (15, "James Buchanan", "1857", "D");					
INSERT INTO presidents (id, name, elected, party) VALUES (16, "Abraham Lincoln", "1861", "R");					
INSERT INTO presidents (id, name, elected, party) VALUES (17, "AnOtherew Johnson", "1865", "D");					
INSERT INTO presidents (id, name, elected, party) VALUES (18, "Ulysses S. Grant", "1869", "R");					
INSERT INTO presidents (id, name, elected, party) VALUES (19, "Rutherford B. Hayes", "1877", "R");					
INSERT INTO presidents (id, name, elected, party) VALUES (20, "James A. Garfield", "1881", "R");					
INSERT INTO presidents (id, name, elected, party) VALUES (21, "Chester A. Arthur", "1881", "R");					
INSERT INTO presidents (id, name, elected, party) VALUES (22, "Grover Cleveland", "1885", "D");					
INSERT INTO presidents (id, name, elected, party) VALUES (23, "Benjamin Harrison", "1889", "R");					
INSERT INTO presidents (id, name, elected, party) VALUES (24, "Grover Cleveland", "1893", "D");					
INSERT INTO presidents (id, name, elected, party) VALUES (25, "William Mckinley", "1897", "R");					
INSERT INTO presidents (id, name, elected, party) VALUES (26, "Theodore Roosevelt", "1901", "R");					
INSERT INTO presidents (id, name, elected, party) VALUES (27, "William Howard Taft", "1909", "R");					
INSERT INTO presidents (id, name, elected, party) VALUES (28, "WooOtherow Wilson", "1913", "D");					
INSERT INTO presidents (id, name, elected, party) VALUES (29, "Warren G. Harding", "1921", "R");					
INSERT INTO presidents (id, name, elected, party) VALUES (30, "Calvin Coolidge", "1923", "R");					
INSERT INTO presidents (id, name, elected, party) VALUES (31, "Herbert Hoover", "1929", "R");					
INSERT INTO presidents (id, name, elected, party) VALUES (32, "Franklin Roosevelt", "1933", "D");					
INSERT INTO presidents (id, name, elected, party) VALUES (33, "Harry S. Truman", "1945", "D");					
INSERT INTO presidents (id, name, elected, party) VALUES (34, "Dwight D Eisenhower", "1953", "R");					
INSERT INTO presidents (id, name, elected, party) VALUES (35, "John F. Kennedy", "1961", "D");					
INSERT INTO presidents (id, name, elected, party) VALUES (36, "Lyndon B. Johnson", "1963", "D");					
INSERT INTO presidents (id, name, elected, party) VALUES (37, "Richard Nixon", "1969", "R");					
INSERT INTO presidents (id, name, elected, party) VALUES (38, "Gerald Ford", "1974", "R");					
INSERT INTO presidents (id, name, elected, party) VALUES (39, "Jimmy Carter", "1977", "D");					
INSERT INTO presidents (id, name, elected, party) VALUES (40, "Ronald Regan", "1981", "R");					
INSERT INTO presidents (id, name, elected, party) VALUES (41, "George H. W. Bush", "1989", "R");					
INSERT INTO presidents (id, name, elected, party) VALUES (42, "Bill Clinton", "1993", "D");					
INSERT INTO presidents (id, name, elected, party) VALUES (43, "George W. Bush", "2001", "R");					
INSERT INTO presidents (id, name, elected, party) VALUES (44, "Barack Obama", "2009", "D");					
INSERT INTO presidents (id, name, elected, party) VALUES (45, "Donald J Trump", "2017", "R");					
INSERT INTO presidents (id, name, elected, party) VALUES (46, "Joe Biden", "2021", "D");										


SELECT name,
    CASE
        WHEN party = 'D' THEN 'Democratic'
        WHEN party = 'R' THEN 'Republican'
        ELSE 'Other'
    END AS 'Political_Party'
FROM presidents;

SELECT count(party) AS total_presidents FROM presidents;


SELECT count(party)*100 / (SELECT count(party) FROM presidents) AS '% Democrats'  FROM presidents
where party = 'D';


SELECT count(party)*100 / (SELECT count(party) FROM presidents) AS '% Republicans'FROM presidents
where party = 'R';

