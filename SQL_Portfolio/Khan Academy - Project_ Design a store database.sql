--Create your own store! Your store should sell one type of things, like clothing or bikes, whatever you want your store to specialize in. You should have a table for all the items in your store, and at least 5 columns for the kind of data you think you'd need to store. You should sell at least 15 items, and use select statements to order your items by price and show at least one statistic about the items.

CREATE TABLE trees (id INTEGER PRIMARY KEY, name TEXT, age INTEGER, quantity INTEGER, price INTEGER);

INSERT INTO trees VALUES (1, "Juniper", 5, 3, 10);
INSERT INTO trees VALUES (2, "Ficus", 5, 2, 25);
INSERT INTO trees VALUES (3, "Black Pine", .5, 3, 30);
INSERT INTO trees VALUES (4, "White Pine", 52, 12, 30);
INSERT INTO trees VALUES (5, "Cotoneaster", 15, 3, 30);
INSERT INTO trees VALUES (6, "Chineese Elm", 5, 1, 120);
INSERT INTO trees VALUES (7, "Blue Spruce", 8, 9, 30);
INSERT INTO trees VALUES (8, "Fire Tree", 2, 1, 30);
INSERT INTO trees VALUES (9, "Redwood", 1, 2, 80);
INSERT INTO trees VALUES (10, "Sequoia", 5, 18, 30);
INSERT INTO trees VALUES (11, "Japanese Maple", 50, 3, 30);
INSERT INTO trees VALUES (12, "Bougainvillea", 27, 2, 50);
INSERT INTO trees VALUES (13, "Azalea", 18, 2, 30);
INSERT INTO trees VALUES (14, "Wisteria", 5, 2, 30);
INSERT INTO trees VALUES (15, "Larch", 25, 3, 3000);

SELECT * FROM trees ORDER BY price;
SELECT SUM(quantity) FROM trees
