USE ships;

-- 3.1. Напишете заявка, която за всеки кораб извежда името му, държавата,
--      броя оръдия и годината на пускане (launched).

SELECT NAME, COUNTRY, NUMGUNS, LAUNCHED
FROM SHIPS
JOIN CLASSES ON SHIPS.CLASS = CLASSES.CLASS;

-- 3.2. Напишете заявка, която извежда имената на корабите, участвали в битка
--      от 1942г.

SELECT DISTINCT SHIP
FROM OUTCOMES
JOIN BATTLES ON OUTCOMES.BATTLE = BATTLES.NAME
WHERE YEAR(DATE) = 1942;