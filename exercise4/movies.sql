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

-- 1.4. Напишете заявка, която извежда името на продуцента и имената на
--      филмите, продуцирани от продуцента на 'Star Wars'.
SELECT NAME, TITLE
FROM MOVIE 
JOIN MOVIEEXEC ON MOVIE.PRODUCERC# = MOVIEEXEC.CERT#
WHERE NAME  = (SELECT NAME
               FROM MOVIEEXEC
                JOIN MOVIE ON MOVIEEXEC.CERT# = MOVIE.PRODUCERC#
                WHERE TITLE = 'Star Wars');


-- 1.5. Напишете заявка, която извежда заглавието, годината и името на 
--      продуцента на всеки филм. Ако за даден филм продуцентът е неизвестен, 
--      за име да се използва стойността NULL.

SELECT TITLE, YEAR, NAME 
FROM MOVIE LEFT JOIN MOVIEEXEC ON MOVIE.PRODUCERC# = MOVIEEXEC.CERT#;


-- 1.6. Напишете заявка, която извежда заглавието, годината, името на 
--      продуцента, името на студиото и адреса на студиото на всеки филм. 
--      Да се включат и филмите, за които продуцентът и/или студиото е
--      неизвестно.

SELECT TITLE, YEAR,MOVIEEXEC.NAME, STUDIO.NAME, STUDIO.ADDRESS
FROM MOVIE
LEFT JOIN MOVIEEXEC ON MOVIE.PRODUCERC# = MOVIEEXEC.CERT#
LEFT JOIN STUDIO ON MOVIE.STUDIONAME = STUDIO.NAME;

-- 1.7. Напишете заявка, която извежда имената на актьорите не участвали в
--      нито един филм.
SELECT NAME 
FROM MOVIESTAR 
LEFT JOIN STARSIN ON MOVIESTAR.NAME = STARSIN.STARNAME
WHERE STARSIN.STARNAME IS NULL;
