USE movies;
-- Да се изведе статистика за броя филмови звезди, родени в следните периоди:
--  – Преди 1960
--  – През 60-те
--  – През 70-те
--  – През и след 1980
-- Таблицата да има две колони – период (напр. '60s') и брой родени.

SELECT 
    CASE 
        WHEN YEAR(BIRTHDATE) < 1960 THEN 'Before 1960'
        WHEN YEAR(BIRTHDATE) >= 1960 AND YEAR(BIRTHDATE) < 1970 THEN '60s'
        WHEN YEAR(BIRTHDATE) >= 1970 AND YEAR(BIRTHDATE) < 1980 THEN '70s'
        ELSE '1980 and after'
    END as PERIOD,
    COUNT(*) AS COUNT 
FROM MOVIESTAR
GROUP BY 
    CASE 
        WHEN YEAR(BIRTHDATE) < 1960 THEN 'Before 1960'
        WHEN YEAR(BIRTHDATE) >= 1960 AND YEAR(BIRTHDATE) < 1970 THEN '60s'
        WHEN YEAR(BIRTHDATE) >= 1970 AND YEAR(BIRTHDATE) < 1980 THEN '70s'
        ELSE '1980 and after'
    END