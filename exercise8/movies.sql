USE [ivani3];
GO

SELECT *
INTO dbo.MOVIESTAR
FROM movies.dbo.MOVIESTAR;

SELECT *
INTO dbo.MOVIEEXEC
FROM movies.dbo.MOVIEEXEC;

SELECT *
INTO dbo.STUDIO
FROM movies.dbo.STUDIO;
-- Да се добави информация за
-- актрисата Nicole Kidman. За
-- нея знаем само, че е родена
-- на 20-и юни 1967.

SELECT * FROM MOVIESTAR;
BEGIN TRANSACTION;
INSERT INTO MOVIESTAR (NAME, BIRTHDATE) VALUES ('Nicole Kidman', '1967-06-20');
SELECT * FROM MOVIESTAR;
ROLLBACK TRANSACTION;


SELECT * FROM MOVIESTAR;


-- Да се изтрият всички
-- продуценти с печалба
-- (networth) под 10 милиона.) под 10 милиона.

SELECT * FROM MOVIEEXEC;
BEGIN TRANSACTION;
DELETE FROM MOVIEEXEC
WHERE NETWORTH < 100000000;
SELECT * FROM MOVIEEXEC;
ROLLBACK TRANSACTION;

-- Да се изтрие информацията
-- за всички филмови звезди, за
-- които не се знае адресът.

SELECT * FROM MOVIESTAR;
BEGIN TRANSACTION;
DELETE FROM MOVIESTAR
WHERE ADDRESS IS NULL;
SELECT * FROM MOVIESTAR;
ROLLBACK TRANSACTION;

-- Да се добави титлата „Pres.“ Pres.“
-- пред името на всеки
-- продуцент, който е и
-- президент на студио.

SELECT * FROM MOVIEEXEC;
SELECT * FROM STUDIO;
BEGIN TRANSACTION;
UPDATE MOVIEEXEC
SET NAME = 'Pres. ' + NAME
WHERE CERT# IN (SELECT PRESC# FROM STUDIO);
SELECT * FROM MOVIEEXEC;
ROLLBACK TRANSACTION;