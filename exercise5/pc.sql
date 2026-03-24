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