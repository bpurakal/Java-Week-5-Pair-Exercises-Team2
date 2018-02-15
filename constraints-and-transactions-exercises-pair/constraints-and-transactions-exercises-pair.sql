-- Write queries to return the following:
-- Make the following changes in the "world" database.

-- 1. Add Superman's hometown, Smallville, Kansas to the city table. The
-- countrycode is 'USA', and population of 45001. (Yes, I looked it up on
-- Wikipedia.)

BEGIN TRANSACTION;
-- SELECT MAX(id) FROM city;
INSERT into city (name, countrycode, district, population, id) values ('Smallville', 'USA', 'Kansas', 45001, 4080);

ROLLBACK;
-- 2. Add Kryptonese to the countrylanguage table. Kryptonese is spoken by 0.0001
-- percentage of the 'USA' population.
insert into countrylanguage (countrycode, language, isofficial, percentage) values ('USA', 'Kyrptonese', false, 0.0001);
SELECT * from countrylanguage

-- 3. After heated debate, "Kryptonese" was renamed to "Krypto-babble", change
-- the appropriate record accordingly.

UPDATE countrylanguage 
SET language = 'Kyrpto-babble' 
WHERE countrycode = 'USA' 
AND language = 'Kryptonese';
-- 4. Set the US captial to Smallville, Kansas in the country table.

 UPDATE country
 SET capital = '4080'
 WHERE code = 'USA' AND capital = '3813';
-- SELECT capital from COUNTRY where code = 'USA';
-- 5. Delete Smallville, Kansas from the city table. (Did it succeed? Why?)

BEGIN TRANSACTION
DELETE FROM city WHERE id = '4080';
ROLLBACK;

-- no because  ERROR: update or delete on table "city" violates foreign key constraint "country_capital_fkey" on table "country"  Detail: Key (id)=(4080) is still referenced from table "country".
-- 6. Return the US captial to Washington.

 UPDATE country
 SET capital = '3813'
 WHERE code = 'USA' AND capital = '4080';
-- SELECT capital from COUNTRY where code = 'USA';
-- 7. Delete Smallville, Kansas from the city table. (Did it succeed? Why?)

BEGIN TRANSACTION
DELETE FROM city WHERE id = '4080';
COMMIT;
-- 8. Reverse the "is the official language" setting for all languages where the
-- country's year of independence is within the range of 1800 and 1972
-- (exclusive).
-- (590 rows affected)
BEGIN TRANSACTION
update countrylanguage
SET isofficial = NOT isofficial
FROM country
WHERE indepyear BETWEEN 1800 AND 1972 AND countrylanguage.countrycode = country.code;

SELECT * from countrylanguage

ROLLBACK;
-- 9. Convert population so it is expressed in 1,000s for all cities. (Round to
-- the nearest integer value greater than 0.)
-- (4079 rows affected)

BEGIN TRANSACTION 
update city
set population = round(population/1000);

select POPULATION FROM city;
commit;

ROLLBACK;

-- 10. Assuming a country's surfacearea is expressed in miles, convert it to
-- meters for all countries where French is spoken by more than 20% of the
-- population.
-- (7 rows affected)

BEGIN TRANSACTION

update country
SET surfacearea = surfacearea*1609
FROM countrylanguage
WHERE countrylanguage.language = 'French' AND countrylanguage.percentage > 20 AND countrylanguage.countrycode = country.code

select * from country

ROLLBACK;
