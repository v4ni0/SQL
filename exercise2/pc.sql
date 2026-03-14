
/*Напишете заявка, която извежда производителя и
честотата на процесора на лаптопите с размер на
харддиска поне 9 GB.*/
USE pc;
SELECT maker, speed 
FROM laptop
Join product on laptop.model = product.model
WHERE hd >= 9;

/*Напишете заявка, която извежда номер на модел
и цена на всички продукти, произведени от
производител с име ‘B’. Сортирайте резултата
така, че първо да се изведат най-скъпите
продукти.*/

SELECT combined.model, combined.price
FROM product
JOIN (SELECT model, price FROM printer UNION
      SELECT model, price FROM laptop UNION
      SELECT model, price FROM pc) combined ON product.model = combined.model
WHERE product.maker = 'B'
ORDER BY combined.price DESC;


/*Напишете заявка, която извежда размерите на
тези харддискове, които се предлагат в поне два
компютъра.*/

SELECT hd 
FROM pc 
GROUP BY hd
HAVING COUNT(*) >= 2;

SELECT DISTINCT p1.hd
FROM pc p1
    JOIN pc p2 ON p1.code != p2.code
WHERE p1.hd = p2.hd;


/*Напишете заявка, която извежда всички двойки
модели на компютри, които имат еднаква честота
на процесора и памет. Двойките трябва да се
показват само по веднъж, например ако вече е
изведена двойката (i, j), не трябва да се извежда
(j, i)
*/
SELECT p1.model, p2.model
FROM pc p1
JOIN pc p2 ON p1.model < p2.model
WHERE p1.speed = p2.speed AND p1.ram = p2.ram;

/*Напишете заявка, която извежда
производителите на поне два различни
компютъра с честота на процесора поне 500 MHz*/

SELECT maker
FROM product
JOIN pc ON product.model = pc.model
WHERE speed >= 500
GROUP BY maker
HAVING COUNT(pc.model) >=2;