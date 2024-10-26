/**COUNT FUNCTION**/
SELECT COUNT(NAME)
FROM CITY
WHERE POPULATION > 100000;

/**SUM FUNCTION**/
SELECT SUM(POPULATION)
FROM CITY
WHERE DISTRICT = 'California'

/**AVERAGES**/
SELECT AVG(POPULATION)
FROM CITY
WHERE DISTRICT = 'California';

/**AVERAGE POPULATION**/
SELECT ROUND(AVG(POPULATION)) /**round up the float numbers to the nearest integer numbers**/
FROM CITY

/**Japan Population**/
SELECT SUM(POPULATION)
FROM CITY
WHERE COUNTRYCODE = 'JPN'

/**Population difference**/
SELECT MAX(POPULATION) - MIN(POPULATION)
FROM CITY

/**We define an employee's total earnings to be their monthly  worked, and the maximum total earnings to be the maximum total earnings for any employee in the Employee table. 
Write a query to find the maximum total earnings for all employees as well as the total number of employees who have maximum total earnings. Then print these values as 2 space-separated integers.**/
SELECT MAX(Total_earnings) AS Max_Earnings, COUNT(*) AS Number_max_earnings /**find the maximum earnings and count all rows that meet conditions in WHERE clause, have aliases to refer to new columns**/
FROM(
    SELECT EMPLOYEE_ID, MONTHS * SALARY AS Total_earnings
    FROM EMPLOYEE) AS All_earnings /**create a temporary set of data (or subquery), aliased as All_earnings, and have 2 columns: Employee_ID and their total earnings by doing the multiplication**/
WHERE Total_earnings = (SELECT MAX(MONTHS * SALARY) FROM EMPLOYEE)/*the nested SELECT statement calculate the maximum earnings across all employees from Employee table**/
/**WHERE clause filters the temporary set Total_earnings to include only employees whose Total_earnings match the maximum earnings calculated in the nested SELECT**/

/**Query the sum of all values in LAT_N and LONG_W rounded to a scale of 2 decimal places**/
SELECT ROUND(SUM(LAT_N),2), ROUND(SUM(LONG_W),2) FROM STATION

/**Query the sum of Northern Latitudes (LAT_N) from STATION having values greater than 38.7880 and less than 137.2345. Truncate your answer to 4 decimal places**/
SELECT TRUNCATE(SUM(LAT_N),4)FROM STATION
WHERE 38.7880<LAT_N AND LAT_N<137.2345;

/**Query the greatest value of the Northern Latitudes (LAT_N) from STATION that is less than 137.2345. Truncate your answer to 4 decimal places**/
SELECT TRUNCATE(MAX(LAT_N),4) FROM STATION
WHERE LAT_N < 137.2345

/**Query the Western Longitude (LONG_W) for the largest Northern Latitude (LAT_N) in STATION that is less than 137.2345. Round your answer to 4 decimal places**/
SELECT ROUND(LONG_W,4) FROM STATION /**then select LONG_W value corresponding to the largest LAT_N value below and round it to 4 decimal places**/
WHERE LAT_N<137.2345 GROUP BY LAT_N DESC LIMIT 1; /**first filter the LAT_N column to show values < 137.2345, then arrange values in descending order and limit 1 to select the first and largest LAT_N value**/

/**Query the smallest Northern Latitude (LAT_N) from STATION that is greater than 38.7780. Round your answer to 4 decimal places**/
SELECT ROUND(MIN(LAT_N),4) FROM STATION WHERE LAT_N > 38.7780

/**Query the Western Longitude (LONG_W)where the smallest Northern Latitude (LAT_N) in STATION is greater than 38.7780. Round your answer to 4 decimal places**/
SELECT ROUND(LONG_W,4) FROM STATION
WHERE LAT_N = (SELECT MIN(LAT_N) FROM STATION WHERE LAT_N > 38.7780); /**first find the minimum value of LAT_N from all LAT_N values > 38.7780, and alias this value to the LAT_N in outer query**/

/**Consider P1(a,b) and P2(c,d) to be two points on a 2D plane.
 a happens to equal the minimum value in Northern Latitude (LAT_N in STATION).
 b happens to equal the minimum value in Western Longitude (LONG_W in STATION).
 c happens to equal the maximum value in Northern Latitude (LAT_N in STATION).
 d happens to equal the maximum value in Western Longitude (LONG_W in STATION).
Query the Manhattan Distance between points P1 and P4 and round it to a scale of 4 decimal places.**/
SELECT ROUND(ABS(MIN(LAT_N) - MAX(LAT_N)) + ABS(MIN(LONG_W) - MAX(LONG_W)),4) /**ABS means absolute, which makes the value always positive**/
FROM STATION

/**Consider P1(a,c) and P2(b,d) to be two points on a 2D plane where (a,b) are the respective minimum and maximum values of Northern Latitude (LAT_N) 
and (c,d) are the respective minimum and maximum values of Western Longitude (LONG_W) in STATION.
Query the Euclidean Distance between points  and  and format your answer to display 4 decimal digits.**/
SELECT ROUND(SQRT(POWER(MAX(LAT_N) - MIN(LAT_N), 2) + POWER(MAX(LONG_W) - MIN(LONG_W), 2)), 4)
FROM STATION;