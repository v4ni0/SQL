USE ships

-- 3.1. Напишете заявка, която извежда страните, чиито кораби са с
--      най-голям брой оръжия.

SELECT COUNTRY
FROM CLASSES
WHERE NUMGUNS >= ALL (SELECT NUMGUNS FROM CLASSES)

-- 3.2. Напишете заявка, която извежда имената на корабите с 16 инчови
--      оръдия (bore).

SELECT NAME 
FROM SHIPS
WHERE CLASS IN (
    SELECT CLASS
    FROM CLASSES
    WHERE BORE = 16
)

-- 3.3. Напишете заявка, която извежда имената на битките, в които са участвали
--      кораби от клас ‘Kongo’.
SELECT BATTLE
FROM OUTCOMES
WHERE SHIP IN(
    SELECT NAME 
    FROM SHIPS 
    WHERE CLASS = 'Kongo'
)

-- 3.4. Напишете заявка, която извежда имената на класовете, чиито брой оръдия е
--      най-голям в сравнение с корабите със същия калибър оръдия (bore).
SELECT CLASS 
FROM CLASSES class1
WHERE NUMGUNS >= ALL(
    SELECT NUMGUNS
    FROM CLASSES class2
    WHERE class1.BORE = class2.BORE
)


-- 3.5. Напишете заявка, която извежда имената на корабите, чиито брой оръдия е
--      най-голям в сравнение с корабите със същия калибър оръдия (bore).

SELECT NAME
FROM SHIPS  
WHERE CLASS IN (SELECT CLASS
                FROM CLASSES c1
                WHERE c1.NUMGUNS >= ALL (SELECT NUMGUNS FROM CLASSES c2 WHERE c1.BORE = c2.BORE))


