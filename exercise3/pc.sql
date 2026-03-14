USE pc

SELECT *
FROM PRODUCT;
-- 2.1. Напишете заявка, която извежда производителите на персонални компютри с
--      честота поне 500.

SELECT maker
FROM PRODUCT
WHERE model in (SELECT model FROM PC WHERE speed >= 500);

-- 2.2. Напишете заявка, която извежда лаптопите, чиято честота е по-ниска от
--      честотата на който и да е персонален компютър.
SELECT *
FROM LAPTOP
WHERE speed < ANY(SELECT speed FROM PC);

-- 2.3. Напишете заявка, която извежда модела на продукта (PC, лаптоп
--      или принтер) с най-висока цена.
SELECT model
FROM (
    (SELECT model, price
    FROM PC)
    UNION
    (SELECT model, price
    FROM LAPTOP)
    UNION
    (SELECT model, price
    FROM PRINTER)
) AS allProducts
WHERE price = (
    SELECT MAX(price) FROM (
        SELECT price FROM PC
        UNION 
        SELECT price FROM Laptop
        UNION 
        SELECT price FROM Printer
    ) AS AllPrices
);

-- 2.4. Напишете заявка, която извежда производителя на цветния
--      принтер с най-ниска цена.

SELECT maker
FROM PRODUCT
WHERE model IN (
    SELECT model
    FROM PRINTER
    WHERE color = 'y' AND price = (
        SELECT MIN(price)
        FROM PRINTER
        WHERE color = 'y'
    )
);

-- 2.5. Напишете заявка, която извежда производителите на тези
--      персонални компютри с най-малко RAM памет, които имат най-бързи процесори.

SELECT maker
FROM product
WHERE model IN(
    SELECT model 
    FROM PC 
    WHERE ram <= ALL(
        SELECT ram FROM PC
    ) AND speed >= ALL(
        SELECT speed FROM PC
    )
)
