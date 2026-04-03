-- Да се изведат всички производители, за които средната цена на произведените компютри е по-ниска
-- от средната цена на техните лаптопи
USE pc;

SELECT maker 
FROM PRODUCT 
JOIN LAPTOP ON PRODUCT.MODEL = LAPTOP.MODEL
GROUP BY maker
HAVING AVG(LAPTOP.PRICE) > (SELECT AVG(PRICE)
FROM product p2
JOIN PC ON p2.MODEL = PC.MODEL
WHERE p2.maker = PRODUCT.MAKER)

-- Един модел компютри може да се предлага в няколко конфигурации с евентуално различна цена. Да
-- се изведат тези модели компютри, чиято средна цена (на различните му конфигурации) е по-ниска от
-- най-евтиния лаптоп, произвеждан от същия производител.

SELECT pc.model
FROM pc
JOIN product ON pc.model = product.model
GROUP BY pc.model
HAVING AVG(pc.price) < (SELECT MIN(LAPTOP.PRICE)
                      FROM LAPTOP
                      JOIN PRODUCT ON LAPTOP.MODEL = PRODUCT.MODEL
                      WHERE PRODUCT.MAKER = product.maker)

