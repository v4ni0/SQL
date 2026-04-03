USE movies
SELECT *
FROM STARSIN


-- За всяка филмова звезда да се изведе името, рождената дата и с кое студио 
-- е записвала най-много филми. (Ако има две студиа с еднакъв брой филми, 
-- да се изведе кое да е от тях)

USE movies
SELECT ms.NAME, ms.BIRTHDATE, (SELECT TOP 1 m.STUDIONAME
                               FROM STARSIN si
                                   JOIN MOVIE m ON si.MOVIETITLE = m.TITLE AND si.MOVIEYEAR = m.YEAR
                               WHERE si.STARNAME = ms.NAME
                               GROUP BY m.STUDIONAME
                               ORDER BY COUNT(*) DESC) AS STUDIO
FROM MOVIESTAR ms

-- Без повторение заглавията и годините на всички филми, заснети преди 1982, 
-- в които е играл поне един актьор (актриса), чието име не съдържа нито 
-- буквата 'k', нито 'b'. Първо да се изведат най-старите филми.

SELECT DISTINCT TITLE, YEAR
FROM MOVIE 
WHERE YEAR < 1982 AND TITLE IN (
    SELECT MOVIETITLE 
    FROM STARSIN 
    WHERE STARNAME NOT LIKE'%k%' AND STARNAME NOT LIKE '%b%'
)
ORDER BY YEAR ASC

SELECT DISTINCT m.TITLE, m.YEAR
FROM MOVIE m
	JOIN STARSIN si ON m.TITLE = si.MOVIETITLE AND m.YEAR = si.MOVIEYEAR
WHERE YEAR < 1982 AND si.STARNAME NOT LIKE '%k%' AND si.STARNAME NOT LIKE '%b%'

-- Заглавията и дължините в часове (length е в минути) на всички филми, които са от същата година, от която е и филмът
-- Terms of Endearment, но дължината им е по-малка или неизвестна

SELECT title 
FROM MOVIE 

SELECT TITLE, LENGTH / 60.0 AS LENGTH_IN_HOURS
FROM MOVIE
WHERE YEAR = (SELECT TOP 1 YEAR FROM MOVIE WHERE TITLE = 'Terms of Endearment')
  AND (
      LENGTH < (SELECT TOP 1 LENGTH FROM MOVIE WHERE TITLE = 'Terms of Endearment') 
      OR LENGTH IS NULL
  );

SELECT * 
FROM MOVIE m1
	JOIN MOVIE m2 ON m2.TITLE = 'Terms of Endearment' AND m1.YEAR = m2.YEAR
WHERE m1.LENGTH IS NULL OR m1.LENGTH < m2.LENGTH


-- Имената на всички продуценти, които са и филмови звезди и са играли в 
-- поне един филм преди 1980 г. и поне един след 1985 г.
SELECT DISTINCT MOVIEEXEC.NAME 
FROM MOVIEEXEC
JOIN STARSIN S1 ON MOVIEEXEC.NAME = S1.STARNAME AND S1.MOVIEYEAR < 1980
JOIN STARSIN S2 ON MOVIEEXEC.NAME = S2.STARNAME AND S2.MOVIEYEAR > 1985

SELECT DISTINCT me.NAME
FROM MOVIEEXEC me
	JOIN MOVIESTAR ms ON me.NAME = ms.NAME
	JOIN STARSIN sib ON sib.STARNAME = ms.NAME AND sib.MOVIEYEAR < 1980
	JOIN STARSIN sia ON sia.STARNAME = ms.NAME AND sia.MOVIEYEAR > 1985

SELECT *
FROM MOVIEEXEC
    JOIN STARSIN S1 ON MOVIEEXEC.NAME = S1.STARNAME

-- Всички черно-бели филми, записани преди най-стария цветен филм 
-- (InColor='y'/'n') на същото студио. 

SELECT TITLE 
FROM MOVIE M1
WHERE INCOLOR = 'N' AND YEAR < ALL(
    SELECT YEAR
    FROM MOVIE M2
    WHERE INCOLOR = 'Y' AND M1.STUDIONAME = M2.STUDIONAME
)

SELECT m1.TITLE, m1.YEAR
FROM MOVIE m1
WHERE m1.INCOLOR = 'N' 
   AND m1.YEAR < (SELECT MIN(m2.YEAR) 
                  FROM MOVIE m2 
                  WHERE m2.STUDIONAME = m1.STUDIONAME AND m2.INCOLOR = 'Y')

--zad3 Напишете заявка, която извежда имената и 
--рождените дати на тези актриси, които са родени през 
--първата половина на годината (януари-юни) и 
--името им не съдържа буквата R. 
--Първо да се изведат най-младите актриси, 
--а ако няколко актриси имат еднаква рождена дата, 
--те да бъдат подредени по азбучен ред на името.

SELECT NAME, BIRTHDATE 
FROM MOVIESTAR 
WHERE MONTH(BIRTHDATE) BETWEEN 1 AND 6 AND NAME NOT LIKE '%R%'
ORDER BY BIRTHDATE DESC, NAME ASC

--zad 4 За всяко студио, чийто адрес съдържа буквата A 
--и имащо поне два филма, да се изведат: име, първа година, в която студиото е снимало филм; 
--брой на (различните) актьори, които са играли във филми, снимани от студиото.
SELECT STUDIONAME, MIN(YEAR), COUNT(DISTINCT STARNAME)
FROM MOVIE
LEFT JOIN STARSIN ON MOVIE.TITLE = STARSIN.MOVIETITLE AND MOVIE.YEAR = STARSIN.MOVIEYEAR
WHERE STUDIONAME IN (SELECT NAME FROM STUDIO WHERE ADDRESS LIKE '%A%')
GROUP BY STUDIONAME 
HAVING COUNT(DISTINCT TITLE) >= 2

SELECT * 
FROM MOVIE 
WHERE STUDIONAME = 'Paramount'

select STUDIO.NAME, min(YEAR), count(distinct STARNAME)
from STUDIO
join movie on STUDIO.NAME = MOVIE.STUDIONAME 
join STARSIN on starsin.MOVIETITLE = movie.TITLE and starsin.MOVIEYEAR = movie.YEAR
where studio.ADDRESS like '%A%'
group by STUDIO.NAME
having count(distinct TITLE)>=2;

--zad2 За всяка филмова звезда да се изведе следната информация: име; заглавие на филм; брой филми, които са заснети в годината на филма (без значение дали актьор е играл в тях). Ако за дадена звезда няма информация в кои филми е играла, за нея да се изведе ред в следния формат: име, null, 0. Пример:
/*Актьор1 Филм1 5
Актьор1 Филм2 0
Актьор1 Филм3 2
Актьор2 null 0*/
select m1.name, s1.movietitle, count(distinct s2.MOVIETITLE)
from MOVIESTAR as m1
left join STARSIN as s1 on  m1.NAME = s1.STARNAME
left join STARSIN as s2 on s1.MOVIEYEAR = s2.MOVIEYEAR
group by m1.name, s1.movietitle
