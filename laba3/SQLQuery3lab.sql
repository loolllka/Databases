--1.INSERT
--	1. Без указания списка полей
INSERT INTO book VALUES ('atitle', 'vauth', 'genr', '30-04-2000', '5');
SELECT * FROM book;
--	2. С указанием списка полей
INSERT INTO shop (title, address, opening_hours, phone_number) VALUES ('IKEA', 'somewhere in Moscow','08:00', '12345678900'); 
SELECT * FROM shop;
--	3. С чтением значения из другой таблицы
INSERT INTO book(title) SELECT title FROM shop;
SELECT * FROM book;

--2. DELETE
--	1. Всех записей
DELETE FROM shop;
SELECT * FROM shop;
--	2. По условию
--INSERT INTO publishing_house VALUES ('ttitle', 'aaddress', '10:00:00', '23456798765', 'emaillll');
--SELECT * FROM publishing_house;
DELETE FROM publishing_house WHERE email_address='email';
SELECT * FROM publishing_house;
--	3. Очистить таблицу
TRUNCATE TABLE book_reception;

--3. UPDATE
--	1. Всех записей
UPDATE book SET author = 'who';
SELECT * FROM book;
--	2. По условию обновляя один атрибут
UPDATE book SET number_of_pages = '8' WHERE title = 'IKEA';
SELECT * FROM book;
--	3. По условию обновляя несколько атрибутов
UPDATE book SET number_of_pages = '15', genre = 'zine' WHERE title = 'IKEA';
SELECT * FROM book;

--4. SELECT
--	1. С определенным набором извлекаемых атрибутов (SELECT atr1, atr2 FROM...)
SELECT title, genre FROM book;
--	2. Со всеми атрибутами (SELECT * FROM...)
SELECT * FROM book;
--	3. С условием по атрибуту (SELECT * FROM ... WHERE atr1 = "")
SELECT * FROM book WHERE title = 'ikea';

--5. SELECT ORDER BY + TOP (LIMIT)
--  1. С сортировкой по возрастанию ASC + ограничение вывода количества записей
SELECT TOP 10 title, author, number_of_pages FROM book ORDER BY number_of_pages;
--  2. С сортировкой по убыванию DESC
SELECT title, number_of_pages FROM book ORDER BY number_of_pages DESC;
--  3. С сортировкой по двум атрибутам + ограничение вывода количества записей
SELECT TOP 8 title, author, genre, number_of_pages FROM book ORDER BY title, author;
--  4. С сортировкой по первому атрибуту, из списка извлекаемых
SELECT * FROM book ORDER BY 1;

--6. Работа с датами. Необходимо, чтобы одна из таблиц содержала атрибут с типом DATETIME.
--  Например, таблица авторов может содержать дату рождения автора.
--ALTER TABLE book ADD author_birthdate DATETIME NULL;
--UPDATE book SET author_birthdate = '8:15:00 05.10.2000' WHERE title = 'atitle';
--UPDATE book SET author_birthdate = '5:58:22 24.12.1995' WHERE title = 'btitle';
--UPDATE book SET author_birthdate = '4:31:58 22.12.1999' WHERE title = 'ikea';
--SELECT * FROM book;

--INSERT INTO sale VALUES ('155.00', '00:52 16.09.2010', '30', '11');
--SELECT * FROM sale;
--SELECT * FROM book;
--SELECT * FROM shop;
--  1. WHERE по дате
SELECT * FROM sale WHERE date_and_time > '00:00:00 2000';
--  2. Извлечь из таблицы не всю дату, а только год. Например, год рождения автора.
--  Для этого используется функция YEAR
SELECT price, YEAR(date_and_time) AS release_year FROM sale; 

--7. SELECT GROUP BY с функциями агрегации
--  1. MIN
SELECT title, MIN(number_of_pages) AS pages FROM book GROUP BY title;
--  2. MAX
SELECT title, MAX(number_of_pages) AS pages FROM book GROUP BY title;
--  3. AVG
SELECT title, AVG(number_of_pages) AS pages FROM book GROUP BY title;
--  4. SUM
SELECT author, SUM(number_of_pages) AS pages FROM book GROUP BY author;
--  5. COUNT
SELECT genre, COUNT(genre) AS books FROM book GROUP BY genre;

--8. SELECT GROUP BY + HAVING
--  1. Написать 3 разных запроса с использованием GROUP BY + HAVING
--Определяем сколько всего страниц во всех книгах с данным названием и выбираем те, где их больше 10
SELECT title, SUM(number_of_pages) AS pages_in_total FROM book GROUP BY title HAVING SUM(number_of_pages) > 10;
--Определяем, по какой минимальной цене были продажи в каждом году и выбираем те данные, цена в которых выше заданной
SELECT YEAR(date_and_time) as year, MIN(price) AS minimal_price FROM sale GROUP BY YEAR(date_and_time) HAVING MIN(price) > '200.00';
--Определяем среднее количество страниц в книге каждого автора
SELECT author, AVG(number_of_pages) AS pages FROM book GROUP BY author HAVING AVG(number_of_pages) > 0;


--9. SELECT JOIN
SELECT * FROM shop;
SELECT * FROM publishing_house;
--  1. LEFT JOIN двух таблиц и WHERE по одному из атрибутов
SELECT * FROM shop LEFT JOIN publishing_house ON id_shop = id_publishing_house WHERE id_shop > 7;
--  2. RIGHT JOIN. Получить такую же выборку, как и в 9.1
SELECT * FROM publishing_house RIGHT JOIN shop ON id_publishing_house = id_shop WHERE id_publishing_house < 12;
--  3. LEFT JOIN трех таблиц + WHERE по атрибуту из каждой таблицы
SELECT * FROM shop LEFT JOIN publishing_house ON id_shop = id_publishing_house LEFT JOIN book ON id_book = id_shop WHERE id_shop > 7 AND id_book > 7;
--  4. FULL OUTER JOIN двух таблиц
SELECT * FROM book FULL OUTER JOIN shop ON id_book = id_shop WHERE id_book < 15;

--10. Подзапросы
--  1. Написать запрос с WHERE IN (подзапрос)
SELECT * FROM sale WHERE date_and_time NOT IN (SELECT DISTINCT date_and_time FROM( SELECT * FROM sale WHERE date_and_time > '00:00:00 2000') AS date_and_time);
--  2. Написать запрос SELECT atr1, atr2, (подзапрос) FROM ...    
SELECT title, author, (SELECT address FROM shop WHERE id_shop = id_book) FROM book;
