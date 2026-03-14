USE movies;
-- 1.1. Напишете заявка, която извежда името на студиото и имената на
--      актьорите, участвали във филми, произведени от това студио,
--      подредени по име на студио.
SELECT *
FROM MOVIE;

SELECT STUDIONAME, STARNAME
FROM MOVIE JOIN STARSIN ON MOVIE.TITLE = STARSIN.MOVIETITLE
ORDER BY STUDIONAME;

-- 1.2. Напишете заявка, която извежда имената на продуцентите на филмите,
--      в които е играл Harrison Ford.

SELECT* FROM
MOVIEEXEC

SELECT DISTINCT NAME 
FROM MOVIEEXEC
JOIN MOVIE ON MOVIEEXEC.CERT# = MOVIE.PRODUCERC#
JOIN STARSIN s ON MOVIE.TITLE = s.MOVIETITLE AND MOVIE.YEAR = s.MOVIEYEAR
WHERE s.STARNAME = 'Harrison Ford';

-- 1.3. Напишете заявка, която извежда имената на актрисите, играли във
--      филми на MGM.
SELECT DISTINCT STARNAME
FROM STARSIN
JOIN MOVIE ON STARSIN.MOVIETITLE = MOVIE.TITLE AND STARSIN.MOVIEYEAR = MOVIE.YEAR
JOIN MOVIESTAR ON MOVIESTAR.NAME = STARSIN.STARNAME
WHERE STUDIONAME = 'MGM' AND GENDER = 'F';