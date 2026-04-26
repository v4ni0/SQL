USE [ivani3];
GO



-- Използвайки две INSERT заявки, съхранете в базата от данни
-- факта, че персонален компютър модел 1100 е направен от
-- производителя C, има процесор 2400 MHz, RAM 2048 MB,
-- твърд диск 500 GB, 52x DVD устройство и струва $299. Нека
-- новият компютър има код 12. Забележка: моделът и CD са от
-- тип низ.
SELECT * FROM PC;
BEGIN TRANSACTION;
INSERT INTO PRODUCT (MODEL, MAKER, TYPE)
VALUES ('1100', 'C', 'PC');
INSERT INTO PC (CODE, MODEL, SPEED, RAM, HD, CD, PRICE)
VALUES (12, '1100', 2400, 2048, 500, '52x', 299);
SELECT * FROM PC;
SELECT * FROM PRODUCT;
ROLLBACK TRANSACTION;

SELECT * FROM PC;

-- Да се изтрие всичката налична информация за компютри
-- модел 1100.

DELETE FROM PC
WHERE MODEL = '1100';

-- За всеки персонален компютър се продава и 15-инчов лаптоп
-- със същите параметри, но с $500 по-скъп. Кодът на такъв
-- лаптоп е със 100 по-голям от кода на съответния компютър.
-- Добавете тази информация в базата.

SELECT * FROM PRODUCT;
SELECT * FROM LAPTOP;
BEGIN TRANSACTION;
INSERT INTO PRODUCT (MODEL, MAKER, TYPE)
SELECT CAST(CAST(model AS int) + 1000 AS varchar(4)), MAKER, 'Laptop'
FROM PRODUCT
WHERE TYPE = 'PC' AND MODEL NOT IN (SELECT MODEL FROM PRODUCT WHERE TYPE = 'Laptop');
SELECT * FROM PRODUCT;
INSERT INTO LAPTOP (CODE, MODEL, SPEED, RAM, HD, PRICE, SCREEN)
SELECT CODE + 100, MODEL, SPEED, RAM, HD, PRICE + 500, 15
FROM PC
WHERE CAST(MODEL AS int) IN (SELECT CAST(MODEL AS int) - 1000 FROM PRODUCT WHERE TYPE = 'Laptop');
SELECT * FROM LAPTOP;
ROLLBACK TRANSACTION;

-- Да се изтрият всички лаптопи, направени от производител,
-- който не произвежда принтери.
BEGIN TRANSACTION;
SELECT * FROM LAPTOP; 
SELECT DISTINCT MAKER 
FROM PRODUCT 
WHERE TYPE = 'Printer';
DELETE FROM LAPTOP
WHERE MODEL IN (SELECT DISTINCT LAPTOP.MODEL 
                FROM LAPTOP 
                JOIN PRODUCT ON LAPTOP.MODEL = PRODUCT.MODEL
                WHERE MAKER NOT IN (
                    SELECT MAKER 
                    FROM PRODUCT 
                    WHERE TYPE = 'Printer'
                ))
SELECT * FROM LAPTOP; 
ROLLBACK TRANSACTION;

-- Производител А купува производител B. На всички продукти
-- на В променете производителя да бъде А.

BEGIN TRANSACTION;
SELECT * FROM PRODUCT;
UPDATE PRODUCT 
SET MAKER = 'A' 
WHERE MAKER = 'B';
SELECT * FROM PRODUCT;
ROLLBACK TRANSACTION;

-- Да се намали два пъти цената на всеки компютър и да се
-- добавят по 20 GB към всеки твърд диск. Упътване: няма нужда
-- от две отделни заявки.

BEGIN TRANSACTION;
SELECT * FROM PC;
UPDATE PC
SET PRICE = PRICE / 2, HD = HD + 20;
SELECT * FROM PC;
ROLLBACK TRANSACTION;

-- За всеки лаптоп от производител B добавете по един инч към
-- диагонала на екрана.

BEGIN TRANSACTION;
SELECT * FROM LAPTOP;
SELECT * FROM PRODUCT;
UPDATE LAPTOP
SET SCREEN = SCREEN + 1 
WHERE MODEL IN (
    SELECT DISTINCT LAPTOP.MODEL 
    FROM LAPTOP 
    JOIN PRODUCT ON LAPTOP.MODEL = PRODUCT.model
    WHERE MAKER = 'B'
)
SELECT * FROM LAPTOP;
ROLLBACK TRANSACTION;

