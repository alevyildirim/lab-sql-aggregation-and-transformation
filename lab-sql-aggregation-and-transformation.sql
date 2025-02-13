USE sakila;

-- CHALLENGE 1

-- 1. You need to use SQL built-in functions to gain insights relating to the duration of movies:
-- Determine the shortest and longest movie durations and name the values as max_duration and min_duration.
SELECT MAX(length) AS max_duration, MIN(length) AS min_duration
FROM film;

-- Express the average movie duration in hours and minutes. Don't use decimals.
-- Hint: Look for floor and round functions.
SELECT concat(FLOOR(AVG(length) / 60), " hours ", round(AVR(length) "½ 60")," minutes" ) AS average_duration FROM film;

-- 2. You need to gain insights related to rental dates:
-- 2.1. Calculate the number of days that the company has been operating.
-- Hint: To do this, use the rental table, and the DATEDIFF() function to subtract the earliest date in the rental_date column from the latest date.

SELECT Datediff(MAX(rental_date), MIN(rental_date)) AS Number_of_operating_days 
FROM rental;

-- 2.2. Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results.
SELECT * FROM rental;

SELECT rental_id, rental_date,
    MONTH(rental_date) AS rental_month,
    DAYNAME(rental_date) AS rental_weekday
FROM rental
LIMIT 20;

-- 3.You need to ensure that customers can easily access information about the movie collection. To achieve this, retrieve the film titles and their rental duration. If any rental duration value is NULL, replace it with the string 'Not Available'. Sort the results of the film title in ascending order.

SELECT title AS film_title,
    IFNULL((
        SELECT DATEDIFF(return_date, rental_date)
        FROM rental
        WHERE inventory_id IN (SELECT inventory_id FROM inventory WHERE film_id = f.film_id)
        LIMIT 1
    ), 'Not Available') AS rental_duration
FROM 
    film f
ORDER BY 
    film_title ASC;

-- CHALLENGE 2
-- 1. Next, you need to analyze the films in the collection to gain some more insights. Using the film table, determine:
-- 1.1 The total number of films that have been released.

SELECT COUNT(*) AS total_number_of_films_released
FROM film;

-- 1.2 The number of films for each rating.
SELECT rating, COUNT(*) AS number_of_films
FROM film
GROUP BY rating;

-- 1.3 The number of films for each rating, sorting the results in descending order of the number of films. This will help you to better understand the popularity of different film ratings and adjust purchasing decisions accordingly.
SELECT rating, COUNT(*) AS number_of_films
FROM film 
GROUP BY rating
ORDER BY number_of_films DESC;

-- Using the film table, determine:
-- 2.1 The mean film duration for each rating, and sort the results in descending order of the mean duration. Round off the average lengths to two decimal places. This will help identify popular movie lengths for each category.

SELECT rating, round(avg(length),2) AS mean_duration
FROM film
GROUP BY rating
ORDER BY mean_duration DESC;

-- 2.2 Identify which ratings have a mean duration of over two hours in order to help select films for customers who prefer longer movies.
SELECT rating, round(avg(length),2) AS mean_duration
FROM film
GROUP BY rating
HAVING avg(length) > 120;

-- BONUS - which actor's last name is not repeated

SELECT last_name
FROM actor
GROUP BY last_name
HAVING COUNT(*) = 1;