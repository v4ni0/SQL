--Za0si30ld034-12-kS
/* Напишете заявка, която извежда името
на корабите, по-тежки (displacement) от
35000.
*/
use ships;
SELECT NAME 
FROM SHIPS
JOIN CLASSES ON SHIPS.CLASS = CLASSES.CLASS
WHERE DISPLACEMENT > 35000;

/*Напишете заявка, която извежда
имената, водоизместимостта и броя
оръдия на всички кораби, участвали в
битката при Guadalcanal.*/

SELECT NAME, DISPLACEMENT, NUMGUNS
FROM SHIPS
JOIN OUTCOMES ON SHIPS.NAME = OUTCOMES.SHIP
JOIN CLASSES ON SHIPS.CLASS = CLASSES.CLASS
WHERE BATTLE = 'Guadalcanal';

SELECT s.NAME, c.DISPLACEMENT, c.NUMGUNS
FROM SHIPS s
    JOIN CLASSES c ON s.CLASS = c.CLASS
    JOIN OUTCOMES o ON s.NAME = o.SHIP
WHERE o.BATTLE = 'Guadalcanal';