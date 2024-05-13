USE MASTER
GO
DROP DATABASE IF EXISTS YGraph
GO
CREATE DATABASE YGraph
GO
USE YGraph
GO

-- Создание таблицы Пользователь (Users)
CREATE TABLE [Users] (
    ID INT PRIMARY KEY,
    [name] VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE,
    RegistrationDate DATE
) AS NODE;

-- Создание таблицы Книга (Book)
CREATE TABLE Book (
    ID INT PRIMARY KEY,
    [Name] VARCHAR(100) NOT NULL,
    Author VARCHAR(100) NOT NULL,
    Genre VARCHAR(50),
    PublicationYear INT
) AS NODE;

-- Создание таблицы Обзор (Review)
CREATE TABLE Review (
    ID INT PRIMARY KEY,
    Rating INT,
    Comment TEXT,
) AS NODE;

CREATE TABLE Subscribing AS EDGE;

CREATE TABLE Publishing ([date] date) AS EDGE;

CREATE TABLE Reading ([date] date) AS EDGE;

-- Вставка данных в таблицу Пользователь (Users)
INSERT INTO [Users] (ID, [name], Email, RegistrationDate) VALUES
(1, 'John Doe', 'john.doe@example.com', '2024-01-01'),
(2, 'Jane Smith', 'jane.smith@example.com', '2024-02-15'),
(3, 'Alice Johnson', 'alice.johnson@example.com', '2024-03-20'),
(4, 'Bob Brown', 'bob.brown@example.com', '2024-04-10'),
(5, 'Emily White', 'emily.white@example.com', '2024-05-05'),
(6, 'Michael Lee', 'michael.lee@example.com', '2024-06-12'),
(7, 'Sophia Garcia', 'sophia.garcia@example.com', '2024-07-18'),
(8, 'Daniel Martinez', 'daniel.martinez@example.com', '2024-08-22'),
(9, 'Olivia Lopez', 'olivia.lopez@example.com', '2024-09-30'),
(10, 'William Perez', 'william.perez@example.com', '2024-10-25');

-- Вставка данных в таблицу Книга (Book)
INSERT INTO Book (ID, [Name], Author, Genre, PublicationYear) VALUES
(1, 'To Kill a Mockingbird', 'Harper Lee', 'Fiction', 1960),
(2, '1984', 'George Orwell', 'Science Fiction', 1949),
(3, 'Pride and Prejudice', 'Jane Austen', 'Romance', 1813),
(4, 'The Great Gatsby', 'F. Scott Fitzgerald', 'Fiction', 1925),
(5, 'The Catcher in the Rye', 'J.D. Salinger', 'Fiction', 1951),
(6, 'Moby-Dick', 'Herman Melville', 'Adventure', 1851),
(7, 'War and Peace', 'Leo Tolstoy', 'Historical Fiction', 1869),
(8, 'The Lord of the Rings', 'J.R.R. Tolkien', 'Fantasy', 1954),
(9, 'Harry Potter and the Philosopher''s Stone', 'J.K. Rowling', 'Fantasy', 1997),
(10, 'The Hitchhiker''s Guide to the Galaxy', 'Douglas Adams', 'Science Fiction', 1979);

-- Вставка данных в таблицу Обзор (Review)
INSERT INTO Review (ID, Rating, Comment) VALUES
(1, 4, 'A classic!'),
(2, 5, 'Absolutely mind-blowing.'),
(3, 5, 'One of the best books I''ve ever read.'),
(4, 3, 'Interesting, but not my favorite.'),
(5, 4, 'Captivating story.'),
(6, 5, 'Couldn''t put it down!'),
(7, 4, 'Great characters and plot.'),
(8, 2, 'Disappointing.'),
(9, 4, 'Enjoyed it thoroughly.'),
(10, 5, 'Highly recommend!');

INSERT INTO Subscribing ($from_id, $to_id)
VALUES ((SELECT $node_id FROM Users WHERE id = 1),
 (SELECT $node_id FROM Users WHERE id = 2)),
 ((SELECT $node_id FROM Users WHERE id = 10),
 (SELECT $node_id FROM Users WHERE id = 5)),
 ((SELECT $node_id FROM Users WHERE id = 2),
 (SELECT $node_id FROM Users WHERE id = 9)),
 ((SELECT $node_id FROM Users WHERE id = 3),
 (SELECT $node_id FROM Users WHERE id = 1)),
 ((SELECT $node_id FROM Users WHERE id = 3),
 (SELECT $node_id FROM Users WHERE id = 6)),
 ((SELECT $node_id FROM Users WHERE id = 4),
 (SELECT $node_id FROM Users WHERE id = 2)),
 ((SELECT $node_id FROM Users WHERE id = 5),
 (SELECT $node_id FROM Users WHERE id = 4)),
 ((SELECT $node_id FROM Users WHERE id = 6),
 (SELECT $node_id FROM Users WHERE id = 7)),
 ((SELECT $node_id FROM Users WHERE id = 6),
 (SELECT $node_id FROM Users WHERE id = 8)),
 ((SELECT $node_id FROM Users WHERE id = 8),
 (SELECT $node_id FROM Users WHERE id = 3));
GO
SELECT *
FROM Subscribing;

INSERT INTO Publishing ($from_id, $to_id, [date])
VALUES ((SELECT $node_id FROM Users WHERE ID = 1),
 (SELECT $node_id FROM Review WHERE ID = 1), '2022-05-05 14:30:00'),
 ((SELECT $node_id FROM Users WHERE ID = 5),
 (SELECT $node_id FROM Review WHERE ID = 1), '2022-05-10 14:30:00'),
 ((SELECT $node_id FROM Users WHERE ID = 8),
 (SELECT $node_id FROM Review WHERE ID = 1), '2022-05-05 14:30:00'),
 ((SELECT $node_id FROM Users WHERE ID = 2),
 (SELECT $node_id FROM Review WHERE ID = 2), '2022-05-10 14:30:00'),
 ((SELECT $node_id FROM Users WHERE ID = 3),
 (SELECT $node_id FROM Review WHERE ID = 3), '2022-06-05 14:30:00'),
 ((SELECT $node_id FROM Users WHERE ID = 4),
 (SELECT $node_id FROM Review WHERE ID = 3), '2022-06-10 14:30:00'),
 ((SELECT $node_id FROM Users WHERE ID = 6),
 (SELECT $node_id FROM Review WHERE ID = 4), '2022-06-05 14:30:00'),
 ((SELECT $node_id FROM Users WHERE ID = 7),
 (SELECT $node_id FROM Review WHERE ID = 4), '2022-06-10 14:30:00'),
 ((SELECT $node_id FROM Users WHERE ID = 1),
 (SELECT $node_id FROM Review WHERE ID = 9), '2022-06-05 14:30:00'),
 ((SELECT $node_id FROM Users WHERE ID = 9),
 (SELECT $node_id FROM Review WHERE ID = 4), '2022-06-10 14:30:00'),
 ((SELECT $node_id FROM Users WHERE ID = 10),
 (SELECT $node_id FROM Review WHERE ID = 9), '2022-07-05 14:30:00');
 GO
SELECT *
FROM Publishing;

INSERT INTO Reading ($from_id, $to_id, [date])
VALUES ((SELECT $node_id FROM Users WHERE ID = 1),
 (SELECT $node_id FROM Book WHERE ID = 6), '2021-09-10 09:45:00'),
 ((SELECT $node_id FROM Users WHERE ID = 5),
 (SELECT $node_id FROM Book WHERE ID = 1), '2021-09-05 09:45:00'),
 ((SELECT $node_id FROM Users WHERE ID = 8),
 (SELECT $node_id FROM Book WHERE ID = 7), '2021-09-10 09:45:00'),
 ((SELECT $node_id FROM Users WHERE ID = 2),
 (SELECT $node_id FROM Book WHERE ID = 2), '2021-10-05 09:45:00'),
 ((SELECT $node_id FROM Users WHERE ID = 3),
 (SELECT $node_id FROM Book WHERE ID = 5), '2021-10-10 09:45:00'),
 ((SELECT $node_id FROM Users WHERE ID = 4),
 (SELECT $node_id FROM Book WHERE ID = 3), '2021-10-05 09:45:00'),
 ((SELECT $node_id FROM Users WHERE ID = 6),
 (SELECT $node_id FROM Book WHERE ID = 4), '2021-10-10 09:45:00'),
 ((SELECT $node_id FROM Users WHERE ID = 7),
 (SELECT $node_id FROM Book WHERE ID = 2), '2021-10-05 09:45:00'),
 ((SELECT $node_id FROM Users WHERE ID = 1),
 (SELECT $node_id FROM Book WHERE ID = 9), '2021-10-10 09:45:00'),
 ((SELECT $node_id FROM Users WHERE ID = 9),
 (SELECT $node_id FROM Book WHERE ID = 8), '2021-11-05 09:45:00'),
 ((SELECT $node_id FROM Users WHERE ID = 10),
 (SELECT $node_id FROM Book WHERE ID = 9), '2021-11-10 09:45:00');
 GO
SELECT *
FROM Reading;


SELECT [User].name, B.name
FROM Users AS [User]
	, Reading
	, Book AS B
WHERE MATCH([User]-(Reading)->B)
	AND [User].name = 'John Doe';

SELECT u.name, r.rating, p.date
FROM Users u
	, Publishing p
	, Review r
WHERE MATCH(u-(p)->r)
AND p.date > '2022-05-10';

SELECT u.name, B.name, r.date
FROM Users AS u
	, Reading AS r
	, Book AS B
WHERE MATCH(u-(r)->B)
AND r.date > '2021-09-10';

SELECT u1.name, u2.name
FROM Users AS u1
	, Subscribing AS s
	, Users AS u2
WHERE MATCH(u1-(s)->u2)
	AND u1.name = 'Michael Lee';

SELECT u.name, r.rating, p.date
FROM Users u
	, Publishing p
	, Review r
WHERE MATCH(u-(p)->r)
AND r.rating > 3

SELECT User1.name AS PersonName
 , STRING_AGG(User2.name, '->') WITHIN GROUP (GRAPH PATH)
AS Subscriptions
FROM Users AS User1
 , Subscribing FOR PATH AS s
 , Users FOR PATH AS User2
WHERE MATCH(SHORTEST_PATH(User1(-(s)->User2)+))
 AND User1.name = 'Michael Lee';

 SELECT User1.name AS PersonName
 , STRING_AGG(User2.name, '->') WITHIN GROUP (GRAPH PATH)
AS Subscriptions
FROM Users AS User1
 , Subscribing FOR PATH AS s
 , Users FOR PATH AS User2
WHERE MATCH(SHORTEST_PATH(User1(-(s)->User2){1,3}))
 AND User1.name = 'Michael Lee';

 SELECT User1.id AS IdFirst
	, User1.name AS First
	, CONCAT(N'user', User1.id) AS [First image name]
	, User2.id AS IdSecond
	, User2.name AS Second
	, CONCAT(N'user', User2.id) AS [Second image name]
FROM Users AS User1
 , Subscribing AS s
 , Users AS User2
WHERE MATCH(User1-(s)->User2);

SELECT [User].id AS IdFirst
	, [User].name AS First
	, CONCAT(N'user', [User].id) AS [First image name]
	, r.id AS IdSecond
	, r.rating AS Second
	, CONCAT(N'review', r.id) AS [Second image name]
FROM Users AS [User]
	, Publishing AS p
	, Review AS r
WHERE MATCH([User]-(p)->r);

SELECT [User].id AS IdFirst
	, [User].name AS First
	, CONCAT(N'user', [User].id) AS [First image name]
	, b.id AS IdSecond
	, b.name AS Second
	, CONCAT(N'book', b.id) AS [Second image name]
FROM Users AS [User]
	, Reading AS rr
	, Book AS b
WHERE MATCH([User]-(rr)->b);