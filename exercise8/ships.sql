USE [ivani3];
GO

-- Два британски бойни кораба (type = 'bb') от
-- класа Nelson - Nelson и Rodney - са били
-- пуснати на вода едновременно през 1927 г.
-- Имали са девет 16-инчови оръдия (bore) и
-- водоизместимост от 34 000 тона
-- (displacement). Добавете тези факти към
-- базата от данни.

INSERT INTO CLASSES (CLASS, TYPE, COUNTRY, NUMGUNS, BORE, DISPLACEMENT)
VALUES ('Nelson', 'bb', 'Gt.Britain', 9, 16, 34000);

INSERT INTO CLASSES (CLASS, TYPE, COUNTRY, NUMGUNS, BORE, DISPLACEMENT)
VALUES ('Rodney', 'bb', 'Gt.Britain', 9, 16, 34000);

-- Изтрийте от Ships всички кораби, които са
-- потънали в битка.

BEGIN TRANSACTION;
SELECT * FROM OUTCOMES
WHERE result = 'sunk';
SELECT * FROM SHIPS
WHERE NAME IN (SELECT ship FROM OUTCOMES
WHERE result = 'sunk');
SELECT DISTINCT ship
INTO #SunkShips
FROM OUTCOMES
WHERE result = 'sunk';
SELECT * FROM #SunkShips;
DELETE FROM OUTCOMES
WHERE result = 'sunk';
DELETE FROM SHIPS
WHERE NAME IN (SELECT ship FROM #SunkShips);
SELECT * FROM SHIPS;
ROLLBACK TRANSACTION;

-- Променете данните в релацията Classes така,
-- че калибърът (bore) да се измерва в
-- сантиметри (в момента е в инчове, 1 инч ~
-- 2.54 см) и водоизместимостта да се измерва в
-- метрични тонове (1 м.т. = 1.1 т.)
BEGIN TRANSACTION;
SELECT * FROM CLASSES;
UPDATE CLASSES
SET BORE = BORE * 2.54, DISPLACEMENT = DISPLACEMENT / 1.1;
SELECT * FROM CLASSES;
ROLLBACK TRANSACTION;

-- Изтрийте всички класове, от които има помалко от три кораба.
BEGIN TRANSACTION;
SELECT CLASS
INTO #DeleteClasses
FROM CLASSES 
WHERE CLASS IN (SELECT 
                CLASSES.CLASS 
                FROM CLASSES 
                JOIN SHIPS ON SHIPS.CLASS = CLASSES.CLASS 
                GROUP BY CLASSES.CLASS 
                HAVING COUNT(*) < 3);

SELECT NAME 
INTO #DeletedShips 
FROM SHIPS 
WHERE CLASS IN (SELECT * FROM #DeleteClasses);

DELETE FROM OUTCOMES 
WHERE OUTCOMES.SHIP IN (SELECT * FROM #DeletedShips);

DELETE FROM SHIPS 
WHERE CLASS IN (SELECT * FROM #DeleteClasses);

DELETE FROM CLASSES
WHERE CLASS IN (SELECT * FROM #DeleteClasses);

ROLLBACK TRANSACTION;

--  Променете калибъра на оръдията и
-- водоизместимостта на класа Iowa, така че да
-- са същите като тези на класа Bismarck

BEGIN TRANSACTION;
SELECT * FROM CLASSES
WHERE CLASS IN ('Iowa', 'Bismarck');
UPDATE CLASSES
SET BORE = (SELECT BORE FROM CLASSES WHERE CLASS = 'Bismarck')
WHERE CLASS = 'Iowa';
UPDATE CLASSES
SET DISPLACEMENT = (SELECT DISPLACEMENT FROM CLASSES WHERE CLASS = 'Bismarck')
WHERE CLASS = 'Iowa';
SELECT * FROM CLASSES
WHERE CLASS IN ('Iowa', 'Bismarck');
ROLLBACK TRANSACTION;

