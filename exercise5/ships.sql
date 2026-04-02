USE ships

-- 2.1. Напишете заявка, която извежда броя на класовете кораби

SELECT COUNT(*)
FROM CLASSES

-- 2.2. Напишете заявка, която извежда средния брой на оръжия за 
--      всички кораби, пуснати на вода

SELECT AVG(NUMGUNS)
FROM CLASSES
JOIN SHIPS ON CLASSES.CLASS = SHIPS.CLASS

-- 2.3. Напишете заявка, която извежда за всеки клас първата и 
--      последната година, в която кораб от съответния клас е пуснат на вода

SELECT CLASS, MIN(LAUNCHED) AS FirstYear, MAX(LAUNCHED) AS LastYear
FROM SHIPS
GROUP BY CLASS

-- 2.4. Напишете заявка, която извежда броя на корабите потънали в битка 
--      според класа

-- 2.4. Напишете заявка, която извежда броя на корабите потънали в битка 
--      според класа

-- ако не се интересуваме от класовете без потънали кораби и класовете без кораби

SELECT s.CLASS, COUNT(*) AS SunkCount
FROM SHIPS s
   JOIN OUTCOMES o ON s.NAME = o.SHIP
WHERE o.RESULT = 'sunk'
GROUP BY s.CLASS
