-- 1. Write a query to find all countries where the population is greater than the average population of all countries in the dataset.
SELECT Name, Population
FROM country
WHERE population >(SELECT AVG(population) FROM country)
ORDER BY Population DESC

/* Total rows = 38
+------------------+----------+
|Name              |Population|
+------------------+----------+
|China             |1277558000|
|India             |1013662000|
|United States     |278357000 |
|Indonesia         |212107000 |
|Brazil            |170115000 |
|Pakistan          |156483000 |
|Russian Federation|146934000 |
|Bangladesh        |129155000 |
|Japan             |126714000 |
|Nigeria           |111506000 |
|Mexico            |98881000  |
|Germany           |82164700  |
|Vietnam           |79832000  |
|Philippines       |75967000  |
|Egypt             |68470000  |
+------------------+----------+
*/

-- 2. Write a query to find the top 5 most spoken languages in the world, along with their total number of speakers.
SELECT Language, SUM(Percentage * c.Population / 100) AS TotalSpeakers
FROM countrylanguage cl
JOIN country c ON cl.CountryCode = c.Code
GROUP BY Language
ORDER BY TotalSpeakers DESC

/* Total rows = 458
 +--------+----------------+
|Language|TotalSpeakers   |
+--------+----------------+
|Chinese |1191843539.00000|
|Hindi   |405633070.00000 |
|Spanish |355029462.00000 |
|English |347077867.30000 |
|Arabic  |233839238.70000 |
+--------+----------------+
 */

 -- 3. Write a query to calculate the population density (population / area) for each country, and return the country name along with its population density. Only include countries with a non-zero area.
SELECT name, Population/SurfaceArea AS populationDensity
FROM country
WHERE SurfaceArea > 0
ORDER BY populationDensity DESC

/* Total rows = 239
 +-----------------------------+-----------------+
|name                         |populationDensity|
+-----------------------------+-----------------+
|Macao                        |26277.7778       |
|Monaco                       |22666.6667       |
|Hong Kong                    |6308.8372        |
|Singapore                    |5771.8447        |
|Gibraltar                    |4166.6667        |
|Holy See (Vatican City State)|2500.0000        |
|Bermuda                      |1226.4151        |
|Malta                        |1203.1646        |
|Maldives                     |959.7315         |
|Bangladesh                   |896.9222         |
|Bahrain                      |889.0490         |
|Barbados                     |627.9070         |
|Taiwan                       |615.0105         |
|Nauru                        |571.4286         |
|Mauritius                    |567.6471         |
+-----------------------------+-----------------+
 */

 --4. Write a query to find all countries that do not have any cities listed in the cities table.
SELECT country.Name, city.Name
FROM country
LEFT JOIN city ON country.Code = city.CountryCode
WHERE city.Name is null

/* Total rows = 7
 +--------------------------------------------+----+
|Name                                        |Name|
+--------------------------------------------+----+
|Antarctica                                  |null|
|French Southern territories                 |null|
|Bouvet Island                               |null|
|Heard Island and McDonald Islands           |null|
|British Indian Ocean Territory              |null|
|South Georgia and the South Sandwich Islands|null|
|United States Minor Outlying Islands        |null|
+--------------------------------------------+----+
 */

 -- 5. Write a query to calculate the average life expectancy for each continent. Include the continent name in the result.
SELECT Continent, AVG(LifeExpectancy) AS `Life Expectancy`
FROM country
GROUP BY Continent
ORDER BY `Life Expectancy` DESC

/* Total rows = 7
 +-------------+---------------+
|Continent    |Life Expectancy|
+-------------+---------------+
|Europe       |75.14773       |
|North America|72.99189       |
|South America|70.94615       |
|Oceania      |69.71500       |
|Asia         |67.44118       |
|Africa       |52.57193       |
|Antarctica   |null           |
+-------------+---------------+
 */

-- 6. Write a query to find cities in countries that have a population within 10% of the population of 'Japan'. Display the city name, country name, and population.
SELECT ct.Name AS CityName, c.Name AS CountryName, ct.Population
FROM country c
         LEFT JOIN city ct ON c.Code = ct.CountryCode
WHERE c.Population BETWEEN (
    (SELECT Population FROM country WHERE Name = 'Japan') * 0.9
    ) AND (
    (SELECT Population FROM country WHERE Name = 'Japan') * 1.1
    )
ORDER BY ct.Population DESC;

/* Total rows = 272
 +-------------------+-----------+----------+
|CityName           |CountryName|Population|
+-------------------+-----------+----------+
|Tokyo              |Japan      |7980230   |
|Dhaka              |Bangladesh |3612850   |
|Jokohama [Yokohama]|Japan      |3339594   |
|Osaka              |Japan      |2595674   |
|Nagoya             |Japan      |2154376   |
|Sapporo            |Japan      |1790886   |
|Kioto              |Japan      |1461974   |
|Kobe               |Japan      |1425139   |
|Chittagong         |Bangladesh |1392860   |
|Fukuoka            |Japan      |1308379   |
|Kawasaki           |Japan      |1217359   |
|Hiroshima          |Japan      |1119117   |
|Kitakyushu         |Japan      |1016264   |
|Sendai             |Japan      |989975    |
|Chiba              |Japan      |863930    |
|Sakai              |Japan      |797735    |
|Khulna             |Bangladesh |663340    |
|Kumamoto           |Japan      |656734    |
|Okayama            |Japan      |624269    |
|Sagamihara         |Japan      |586300    |
+-------------------+-----------+----------+
 */