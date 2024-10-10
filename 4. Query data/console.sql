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

-- 7. Write a query to rank countries by their GDP in descending order. Show the country name and its GDP, and add a rank column.
SELECT ROW_NUMBER() OVER(ORDER BY GNP DESC) AS `rank`, Name, GNP
FROM country;

/* Total rows = 239
+----+--------------------------------------------+----------+
|rank|Name                                        |GNP       |
+----+--------------------------------------------+----------+
|1   |United States                               |8510700.00|
|2   |Japan                                       |3787042.00|
|3   |Germany                                     |2133367.00|
|4   |France                                      |1424285.00|
|5   |United Kingdom                              |1378330.00|
|6   |Italy                                       |1161755.00|
|7   |China                                       |982268.00 |
|8   |Brazil                                      |776739.00 |
|9   |Canada                                      |598862.00 |
|10  |Spain                                       |553233.00 |
|11  |India                                       |447114.00 |
|12  |Mexico                                      |414972.00 |
|13  |Netherlands                                 |371362.00 |
|14  |Australia                                   |351182.00 |
|15  |Argentina                                   |340238.00 |
+----+--------------------------------------------+----------+
*/

-- 8. Write a query to find countries whose GDP is higher than that of any of their neighboring countries. Assume neighboring countries are defined by the neighbor relationship in the countries table.
SELECT c1.Name, c1.Region, c1.GNP
FROM country AS c1
WHERE c1.GNP > 0
  AND NOT EXISTS (
    SELECT 1
    FROM country AS c2
    WHERE c1.Region = c2.Region AND c1.Name != c2.Name AND c2.GNP > c1.GNP
)
ORDER BY c1.GNP DESC;

/* Total rows = 23
+------------------+-------------------------+----------+
|Name              |Region                   |GNP       |
+------------------+-------------------------+----------+
|United States     |North America            |8510700.00|
|Japan             |Eastern Asia             |3787042.00|
|Germany           |Western Europe           |2133367.00|
|United Kingdom    |British Islands          |1378330.00|
|Italy             |Southern Europe          |1161755.00|
|Brazil            |South America            |776739.00 |
|India             |Southern and Central Asia|447114.00 |
|Mexico            |Central America          |414972.00 |
|Australia         |Australia and New Zealand|351182.00 |
|Russian Federation|Eastern Europe           |276608.00 |
|Sweden            |Nordic Countries         |226492.00 |
|Turkey            |Middle East              |210721.00 |
|Myanmar           |Southeast Asia           |180375.00 |
|South Africa      |Southern Africa          |116729.00 |
|Egypt             |Northern Africa          |82710.00  |
|Nigeria           |Western Africa           |65707.00  |
|Puerto Rico       |Caribbean                |34100.00  |
|Lithuania         |Baltic Countries         |10692.00  |
|Kenya             |Eastern Africa           |9217.00   |
|Cameroon          |Central Africa           |9174.00   |
|Papua New Guinea  |Melanesia                |4988.00   |
|Guam              |Micronesia               |1197.00   |
|French Polynesia  |Polynesia                |818.00    |
+------------------+-------------------------+----------+
*/

-- 9. Write a query to find the number of countries where each language is spoken. Show the language and the count of countries speaking that language, ordered by the count in descending order.
SELECT Language, COUNT(CountryCode) AS country_count
FROM countrylanguage
GROUP BY Language
ORDER BY country_count DESC;

/* Total rows = 458
 +-------------------------+-------------+
|Language                 |country_count|
+-------------------------+-------------+
|English                  |60           |
|Arabic                   |33           |
|Spanish                  |28           |
|French                   |25           |
|German                   |19           |
|Chinese                  |19           |
|Russian                  |17           |
|Italian                  |15           |
|Creole English           |14           |
|Portuguese               |12           |
|Turkish                  |12           |
|Ful                      |12           |
|Ukrainian                |12           |
|Polish                   |10           |
|Serbo-Croatian           |9            |
+-------------------------+-------------+
*/

-- 10. Write a query to find all cities where the city population is greater than the average population of their respective countries. Show the city name, country name, and both populations.
SELECT city.Name, country.Name AS CountryName, city.Population AS CityPopulation, avg_city.AvgCountryPopulation
FROM city
JOIN country ON city.CountryCode = country.Code
JOIN (
    SELECT CountryCode, AVG(Population) AS AvgCountryPopulation
    FROM city
    GROUP BY CountryCode
) AS avg_city ON city.CountryCode = avg_city.CountryCode
WHERE city.Population > avg_city.AvgCountryPopulation
ORDER BY AvgCountryPopulation DESC;

/* Total rows = 915
+------------------------------+-------------------------------------+--------------+--------------------+
|Name                          |CountryName                          |CityPopulation|AvgCountryPopulation|
+------------------------------+-------------------------------------+--------------+--------------------+
|Kowloon and New Kowloon       |Hong Kong                            |1987996       |1650316.5000        |
|Sydney                        |Australia                            |3276207       |808119.0000         |
|Melbourne                     |Australia                            |2865329       |808119.0000         |
|Brisbane                      |Australia                            |1291117       |808119.0000         |
|Perth                         |Australia                            |1096829       |808119.0000         |
|Adelaide                      |Australia                            |978100        |808119.0000         |
|Brazzaville                   |Congo                                |950000        |725000.0000         |
|Tripoli                       |Libyan Arab Jamahiriya               |1682000       |674251.7500         |
|Bengasi                       |Libyan Arab Jamahiriya               |804000        |674251.7500         |
|Beirut                        |Lebanon                              |1100000       |670000.0000         |
|Bangkok                       |Thailand                             |6320174       |662763.4167         |
|Abidjan                       |Côte d’Ivoire                        |2500000       |638227.4000         |
|Bakı                          |Azerbaijan                           |1787800       |616000.0000         |
|Baghdad                       |Iraq                                 |4336000       |595069.4000         |
|Mosul                         |Iraq                                 |879000        |595069.4000         |
|Kabul                         |Afghanistan                          |1780000       |583025.0000         |
|Seoul                         |South Korea                          |9981619       |557141.3286         |
|Pusan                         |South Korea                          |3804522       |557141.3286         |
+------------------------------+-------------------------------------+--------------+--------------------+
*/