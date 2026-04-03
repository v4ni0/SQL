USE ships;
-- Намерете броя на потъналите американски кораби за всяка проведена битка 
-- с поне един потънал американски кораб.

SELECT OUTCOMES.BATTLE, COUNT(*) 
FROM OUTCOMES 
JOIN SHIPS ON SHIPS.NAME = OUTCOMES.SHIP 
JOIN CLASSES ON CLASSES.CLASS = SHIPS.CLASS 
WHERE CLASSES.COUNTRY = 'USA' AND OUTCOMES.RESULT = 'sunk'
GROUP BY OUTCOMES.BATTLE 
HAVING COUNT(*) >= 1;

--  Битките, в които са участвали поне 3 кораба на една и съща страна.
SELECT BATTLE
FROM OUTCOMES 
JOIN SHIPS ON SHIPS.NAME = OUTCOMES.SHIP 
JOIN CLASSES ON SHIPS.CLASS = CLASSES.CLASS
GROUP BY BATTLE, COUNTRY 
HAVING COUNT(*) >= 3

-- Имената на класовете, за които няма кораб, пуснат на вода след 1921 г., 
-- но имат пуснат поне един кораб.

SELECT DISTINCT CLASSES.CLASS 
FROM CLASSES 
JOIN SHIPS ON SHIPS.NAME = CLASSES.CLASS
GROUP BY CLASSES.CLASS 
HAVING MAX(LAUNCHED) <= 1921 AND COUNT(*) >= 1

SELECT CLASS
FROM SHIPS 
GROUP BY CLASS
HAVING MAX(LAUNCHED) <= 1921

-- За всеки кораб броя на битките, в които е бил увреден (result = ‘damaged’). Ако корабът не е участвал
-- в битки или пък никога не е бил увреждан, в резултата да се вписва 0.

SELECT s.NAME, 
       SUM(CASE WHEN o.RESULT = 'damaged' THEN 1 ELSE 0 END) AS DamagedCount
FROM SHIPS s
    LEFT OUTER JOIN OUTCOMES o ON s.NAME = o.SHIP
GROUP BY s.NAME;

SELECT s.NAME, COUNT(o.RESULT)
FROM SHIPS s
    LEFT OUTER JOIN OUTCOMES o ON s.NAME = o.SHIP AND o.RESULT = 'damaged'
GROUP BY s.NAME


-- За всяка държава да се изведе броят на корабите и броят на потъналите кораби.

SELECT CLASSES.COUNTRY, COUNT(DISTINCT SHIPS.NAME) AS TotalShips, SUM(CASE WHEN OUTCOMES.RESULT = 'sunk' THEN 1 ELSE 0 END) AS SunkCount
FROM CLASSES 
LEFT JOIN SHIPS ON CLASSES.CLASS = SHIPS.CLASS 
LEFT JOIN OUTCOMES ON SHIPS.NAME = OUTCOMES.SHIP
GROUP BY CLASSES.COUNTRY;

SELECT c.COUNTRY, COUNT(s.NAME), COUNT(o.RESULT)
FROM CLASSES c
    LEFT OUTER JOIN SHIPS s ON c.CLASS = s.CLASS
    LEFT OUTER JOIN OUTCOMES o ON o.SHIP = s.NAME AND o.RESULT = 'sunk'
GROUP BY c.COUNTRY

-- За всяка държава да се изведе броят на повредените кораби и броят на 
-- потъналите кораби. Всяка от бройките може да бъде и нула.

SELECT COUNTRY, 
       SUM(CASE WHEN OUTCOMES.RESULT = 'damaged' THEN 1 ELSE 0 END) AS DamagedCount,
       SUM(CASE WHEN OUTCOMES.RESULT = 'sunk' THEN 1 ELSE 0 END) AS SunkCount
FROM CLASSES
LEFT JOIN SHIPS ON SHIPS.CLASS = CLASSES.CLASS
LEFT JOIN OUTCOMES ON OUTCOMES.SHIP = SHIPS.NAME
GROUP BY COUNTRY

SELECT c.COUNTRY, COUNT(DISTINCT damaged.SHIP) AS DAMAGED, COUNT(DISTINCT sunk.SHIP) AS SUNK
FROM CLASSES c
    LEFT OUTER JOIN SHIPS s ON c.CLASS = s.CLASS
    LEFT OUTER JOIN OUTCOMES damaged ON s.NAME = damaged.SHIP AND damaged.RESULT = 'damaged'
    LEFT OUTER JOIN OUTCOMES sunk ON s.NAME = sunk.SHIP AND sunk.RESULT = 'sunk'
GROUP BY c.COUNTRY

--  Намерете за всеки клас с поне 3 кораба броя на корабите от този клас, които са победили в битка
-- (result = 'ok')

SELECT SHIPS.CLASS, COUNT(DISTINCT SHIPS.NAME) AS OKCount
FROM SHIPS 
LEFT JOIN OUTCOMES ON SHIPS.NAME = OUTCOMES.SHIP AND OUTCOMES.RESULT = 'ok'
GROUP BY SHIPS.CLASS
HAVING COUNT(DISTINCT SHIPS.NAME) >= 3

-- За всеки кораб, който е от клас с име, несъдържащо буквите i и k, да се изведе 
-- името на кораба и през коя година е пуснат на вода (launched). Резултатът да бъде 
-- сортиран така, че първо да се извеждат най-скоро пуснатите кораби.

SELECT NAME, CLASS, LAUNCHED 
FROM SHIPS
WHERE CLASS NOT LIKE '%i%' AND CLASS NOT LIKE '%k%'
ORDER BY LAUNCHED DESC

-- Да се изведат имената на всички битки, в които е повреден (damaged) 
-- поне един японски кораб.

SELECT DISTINCT BATTLE 
FROM OUTCOMES 
WHERE RESULT = 'damaged' AND SHIP IN  (
    SELECT NAME 
    FROM SHIPS 
    JOIN CLASSES ON SHIPS.CLASS = CLASSES.CLASS
    WHERE CLASSES.COUNTRY = 'Japan'
)

SELECT DISTINCT o.BATTLE
FROM OUTCOMES o
	JOIN SHIPS s ON s.NAME = o.SHIP
	JOIN CLASSES c ON c.CLASS = s.CLASS
WHERE o.RESULT = 'damaged' AND c.COUNTRY = 'Japan'