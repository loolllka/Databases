--1.INSERT
--	1. ��� �������� ������ �����
INSERT INTO book VALUES ('atitle', 'vauth', 'genr', '30-04-2000', '5');
SELECT * FROM book;
--	2. � ��������� ������ �����
INSERT INTO shop (title, address, opening_hours, phone_number) VALUES ('IKEA', 'somewhere in Moscow','08:00', '12345678900'); 
SELECT * FROM shop;
--	3. � ������� �������� �� ������ �������
INSERT INTO book(title) SELECT title FROM shop;
SELECT * FROM book;

--2. DELETE
--	1. ���� �������
DELETE FROM shop;
SELECT * FROM shop;
--	2. �� �������
--INSERT INTO publishing_house VALUES ('ttitle', 'aaddress', '10:00:00', '23456798765', 'emaillll');
--SELECT * FROM publishing_house;
DELETE FROM publishing_house WHERE email_address='email';
SELECT * FROM publishing_house;
--	3. �������� �������
TRUNCATE TABLE book_reception;

--3. UPDATE
--	1. ���� �������
UPDATE book SET author = 'who';
SELECT * FROM book;
--	2. �� ������� �������� ���� �������
UPDATE book SET number_of_pages = '8' WHERE title = 'IKEA';
SELECT * FROM book;
--	3. �� ������� �������� ��������� ���������
UPDATE book SET number_of_pages = '15', genre = 'zine' WHERE title = 'IKEA';
SELECT * FROM book;

--4. SELECT
--	1. � ������������ ������� ����������� ��������� (SELECT atr1, atr2 FROM...)
SELECT title, genre FROM book;
--	2. �� ����� ���������� (SELECT * FROM...)
SELECT * FROM book;
--	3. � �������� �� �������� (SELECT * FROM ... WHERE atr1 = "")
SELECT * FROM book WHERE title = 'ikea';

--5. SELECT ORDER BY + TOP (LIMIT)
--  1. � ����������� �� ����������� ASC + ����������� ������ ���������� �������
SELECT TOP 10 title, author, number_of_pages FROM book ORDER BY number_of_pages;
--  2. � ����������� �� �������� DESC
SELECT title, number_of_pages FROM book ORDER BY number_of_pages DESC;
--  3. � ����������� �� ���� ��������� + ����������� ������ ���������� �������
SELECT TOP 8 title, author, genre, number_of_pages FROM book ORDER BY title, author;
--  4. � ����������� �� ������� ��������, �� ������ �����������
SELECT * FROM book ORDER BY 1;

--6. ������ � ������. ����������, ����� ���� �� ������ ��������� ������� � ����� DATETIME.
--  ��������, ������� ������� ����� ��������� ���� �������� ������.
--ALTER TABLE book ADD author_birthdate DATETIME NULL;
--UPDATE book SET author_birthdate = '8:15:00 05.10.2000' WHERE title = 'atitle';
--UPDATE book SET author_birthdate = '5:58:22 24.12.1995' WHERE title = 'btitle';
--UPDATE book SET author_birthdate = '4:31:58 22.12.1999' WHERE title = 'ikea';
--SELECT * FROM book;
--  1. WHERE �� ����
SELECT * FROM book WHERE author_birthdate > '00:00:00 2000';
--  2. ������� �� ������� �� ��� ����, � ������ ���. ��������, ��� �������� ������.
--  ��� ����� ������������ ������� YEAR
SELECT author, YEAR(author_birthdate) FROM book; 

--7. SELECT GROUP BY � ��������� ���������
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
--  1. �������� 3 ������ ������� � �������������� GROUP BY + HAVING
--���������� ������� ����� ������� �� ���� ������ � ������ ��������� � �������� ��, ��� �� ������ 10
SELECT title, SUM(number_of_pages) AS pages_in_total FROM book GROUP BY title HAVING SUM(number_of_pages) > 10;
--����������, ����� �� ����� ������� ������� �������� ����� ��������� �����
SELECT author, MIN(author_birthdate) AS birthdate FROM book GROUP BY author HAVING MIN(author_birthdate) > '00:00:00 2000';
--���������� ������� ���������� ������� � ����� ������� ������
SELECT author, AVG(number_of_pages) AS pages FROM book GROUP BY author HAVING AVG(number_of_pages) > 0;


--9. SELECT JOIN
SELECT * FROM shop;
SELECT * FROM publishing_house;
--  1. LEFT JOIN ���� ������ � WHERE �� ������ �� ���������
SELECT * FROM shop LEFT JOIN publishing_house ON id_shop = id_publishing_house WHERE id_shop > 7;
--  2. RIGHT JOIN. �������� ����� �� �������, ��� � � 9.1
SELECT * FROM publishing_house RIGHT JOIN shop ON id_publishing_house = id_shop WHERE id_publishing_house < 12;
--  3. LEFT JOIN ���� ������ + WHERE �� �������� �� ������ �������
SELECT * FROM shop LEFT JOIN publishing_house ON id_shop = id_publishing_house LEFT JOIN book ON id_book = id_shop WHERE id_shop > 7 AND id_book > 7;
--  4. FULL OUTER JOIN ���� ������
SELECT * FROM book FULL OUTER JOIN shop ON id_book = id_shop WHERE id_book < 15;

--10. ����������
--  1. �������� ������ � WHERE IN (���������)
SELECT * FROM book WHERE author_birthdate NOT IN (SELECT DISTINCT author_birthdate FROM( SELECT * FROM book WHERE author_birthdate > '00:00:00 2000') AS author_birthdate);
--  2. �������� ������ SELECT atr1, atr2, (���������) FROM ...    
SELECT title, author, (SELECT address FROM shop WHERE id_shop = id_book) FROM book;