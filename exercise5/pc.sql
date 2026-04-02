USE pc

-- 1.1. Напишете заявка, която извежда средната честота на компютрите
SELECT AVG(speed)
FROM pc;

-- 1.2. Напишете заявка, която извежда средния размер на екраните на 
--      лаптопите  за всеки производител
SELECT maker, AVG(screen)
FROM laptop
JOIN product ON laptop.model = product.model
GROUP BY maker;

-- 1.3. Напишете заявка, която извежда средната честота на лаптопите 
--      с цена над 1000 лв.
SELECT AVG(speed)
FROM laptop
WHERE price > 1000;

-- 1.4. Напишете заявка, която извежда средната цена на компютрите 
--      произведени от производител ‘A’

SELECT AVG(price) as average_price
FROM pc 
JOIN product ON pc.model = product.model
WHERE maker = 'A';

-- 1.5. Напишете заявка, която извежда средната цена на компютрите 
--      и лаптопите за производител ‘B’
SELECT AVG(price) AveragePrice
FROM (SELECT price
      FROM product p 
          JOIN pc ON p.model = pc.model
      WHERE maker = 'B'
      UNION ALL
      SELECT price
      FROM product p 
          JOIN laptop ON p.model = laptop.model
      WHERE maker = 'B') u

-- 1.6. Напишете заявка, която извежда средната цена на компютрите 
--      според различните им честоти

SELECT speed, avg(price) 
FROM PC 
GROUP BY SPEED

-- 1.7. Напишете заявка, която извежда производителите, които са 
--      произвели поне по 3 различни модела компютъра

SELECT maker 
FROM product
WHERE type = 'PC'
GROUP BY maker
HAVING COUNT(*) >= 3
-- 1.8. Напишете заявка, която извежда производителите на компютрите с 
--      най-висока цена
SELECT maker 
FROM pc
JOIN product ON pc.model = product.model
WHERE price = (SELECT MAX(price) FROM pc)

-- 1.9. Напишете заявка, която извежда средната цена на компютрите 
--      за всяка честота по-голяма от 800
SELECT speed, AVG(price) AveragePrice
FROM pc
WHERE speed > 800
GROUP BY speed

-- 1.10. Напишете заявка, която извежда средния размер на диска на 
--       тези компютри произведени от производители, които произвеждат 
--       и принтери

SELECT AVG(hd)
FROM product 
JOIN pc ON product.model = pc.model
WHERE maker IN (SELECT maker FROM product WHERE type = 'Printer')

-- 1.11. Напишете заявка, която за всеки размер на лаптоп намира разликата 
--       в цената на най-скъпия и най-евтиния лаптоп със същия размер

SELECT screen, MAX(price) - MIN(price)
FROM laptop
GROUP BY screen

