
-- 1.1. Напишете заявка, която извежда имената на актрисите, които са също и
--      продуценти с нетна стойност по-голяма от 10 милиона.

use movies;

SELECT *
FROM MOVIESTAR

SELECT NAME
FROM MOVIESTAR
WHERE GENDER = 'F' AND NAME IN (SELECT NAME FROM MOVIEEXEC WHERE NETWORTH > 10000000)

-- 1.2. Напишете заявка, която извежда имената на тези актьори (мъже и
--      жени), които не са продуценти.

SELECT NAME
FROM MOVIESTAR
WHERE NAME NOT IN (SELECT NAME FROM MOVIEEXEC)

