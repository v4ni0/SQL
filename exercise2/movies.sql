--Za0si30ld034-12-kS

/* Напишете заявка,
която извежда имената
на актрисите,
участвали в Terms of
Endearment. */

SELECT STARNAME 
FROM STARSIN
WHERE MOVIETITLE = 'Terms of Endearment'
INTERSECT (SELECT NAME FROM MOVIESTAR WHERE GENDER = 'F');

/*Напишете заявка,
която извежда имената
на филмовите звезди,
участвали във филми
на студио MGM през
1995 г.*/

SELECT starName
FROM STARSIN
JOIN MOVIE ON MOVIETITLE = TITLE AND YEAR = MOVIEYEAR
WHERE STUDIONAME = 'MGM' AND YEAR = 1995;

/*Напишете заявка, която извежда производителя и
честотата на процесора на лаптопите с размер на
харддиска поне 9 GB.*/


