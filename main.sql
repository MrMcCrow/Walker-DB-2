-- this imports and executes the schema, then the data
.system clear
.read schema.sql
.read data.sql
.mode column
.headers on
.separator ROW "\n"
.nullvalue NULL


-- now let's do something with what was created! :)
-- a wide range of queries below from the Sakila example database that can be adapted to play with this Walker database

-- SELECT COUNT (*), walkerNo FROM Walker;

--select * from Planner Limit 5;
-- select * from Planner;

-- select * from Route limit 5;
-- select * from Walk limit 5;
--select * from Walker limit 5;
-- INSERT INTO Walker VALUES(564024,"Dugal","McCrow","Grantown Grammar","Edinburgh","PH26 3HU","07115 130408");
-- select * from Walker where walkerNo = 564024;
-- select * from country limit 5;
-- select * from customer limit 5;
-- select * from film limit 5;
-- select * from film_actor limit 5;
-- select * from film_category limit 5;
-- select * from inventory limit 5;
-- select * from language limit 5;
-- select * from payment limit 5;
-- select * from rental limit 5;
-- select * from staff limit 5;
-- select * from store limit 5;


-- select "Actors and Films with PG* and DANGER in title";

-- select last_name || ', ' || first_name, 
  --   title, rating, release_year 
  -- from actor 
  -- join film_actor using (actor_id) 
  -- join film using (film_id) 
  -- where rating like 'PG%' 
  --   AND title like '%DANGER%'
  -- order by last_name
  -- limit 100;

-- 1. Select the total amount paid by customer with customer_id=8 (use the payment table).


--select sum(amount) from payment 
--where customer_id=8;


-- 2. Select the total amount sold by staff with staff_id=2, rounded to nearest dollar (use the payment table).
--select round(sum(amount))
--from payment where staff_id=2;

-- 3. List the title of all films with category.name='Foreign' (need to join tables film, film_category, and category)


--select title from film 
--join film_category using  (film_id)
--join category using (category_id)
--where category.name='Music';
--where category.name='Foreign';


-- 4. List the film titles with the word HOTEL in the title (should have 2 rows).
-- 5. List the emails of all customers with a first name ending in IN. (should have 15 rows)
-- 6. How many times did customer with customer_id=19 rent a movie (rental table) in the month of June (rental_date). Hint: Use the function MONTH(date), which provides the numeric month of the date passed into it Your query should only return one row and one column, and the value should be 3.
-- 7. Select all fields from the address table where the address includes the word DRIVE (you should match any case—so, use upper() or lower() on the field).


--select last_name, first_name from actor
      --join film_actor using (actor_id)
      --where actor.last_name= "HOPE";


--Samples

--SELECT *FROM film;
--SELECT title, rental_rate FROM film; 
--SELECT title, rating FROM film where rating = 'R';
--SELECT title FROM film where rating = 'R';
--SELECT title, rental_rate FROM film where rental_rate > '2.99';
--SELECT title, rental_rate, rating FROM film where rental_rate > '2.99' or rating = 'R';
--SELECT title, rating FROM film where rating = 'R' order by title desc;

--select title, name from film
  --join film_category using  (film_id)
  --join category using (category_id)
  --where category.name='Foreign';

  --Business Case Examples
  -- 1. Report to list all the Foreign film rentals for the first three months of the year (January, February, March).  List the total revenue from those films.

--SELECT * FROM rental
--WHERE return_date >= '2005-05-24' AND rental_date < '2005-08-02' limit 5;


-- 2.	Reports to list the number of times each film was rented.  (List the film name, actors in the film and number of times the film has been rented)
--select title, rental_date, actor.last_name from film
--join film_actor using (film_id)
--join actor using (actor_id)
--join inventory using (film_id)
--join rental using (inventory_id)
--ORDER BY title;

-- 3.	Report that lists the name of the films, the number of times it has been rented and the total revenue the film has generated.  Also list the total of revenue all films have generated in the database.

--select title, rental_date, rating, release_year, payment.amount from film
--join inventory using (film_id)
--join rental using (inventory_id)
--join payment using (rental_id)
--ORDER BY title;
--ORDER BY title Limit 50; 
--SELECT SUM(amount) AS "TOTAL REVENUE:"
--SELECT AVG(amount) AS "TOTAL REVENUE:"
--FROM payment;

-- 4.	Report that lists the store ID, first name, last name, and full street address of each customer in the database, ordered by last name.
--select customer_id, store_id, first_name, last_name, address.address, address.address2, city.city_id, address.postal_code from customer
--join address using (address_id)
--join city using (city_id)
--ORDER BY last_name;

-- 5.	Report that lists the first name, last name, and full street address of every employee the store with store_id of 2
--select first_name, last_name, address.address, city.city, address.postal_code from staff
--join address using (address_id)
--join city using (city_id)
--where store_id = '2';

-- 6.	Report that lists a title, description, and runtime of every film with a rating of "R" and a category of "Horror". Order alphabetically by title.
--select title, length, description from film
--join film_category using (film_id)
--join category using (category_id)
--where category.name = "Horror"
--and
--rating = "R"
--ORDER BY title;

-- 7. BUSINESS QUESTION: Find customers who have rented movies for 9.99
--SELECT customer_id, first_name, last_name
--FROM customer
--WHERE customer_id IN (SELECT customer_id FROM payment WHERE amount = 9.99)
--LIMIT 5;

-- 8. Group choice 2#:
--BUSINESS QUESTION: Find customer in store that spent less than 2.99 on individual rentals, but have spent a total higher than 5.00

--SELECT customer_id, SUM(amount)
--FROM (SELECT payment_id, customer_id, amount FROM payment a where a.staff_id=1) sub
--WHERE sub.amount < 2.99
--GROUP BY sub.customer_id HAVING SUM(sub.amount)>= 5;

-- 9. Group choice 3#:
--BUSINESS QUESTION: Find the average film length in the film table
--INPUT:
--This can be done in two ways
--1.
--SELECT AVG(length) AS average FROM film;
--2.
--SELECT SUM(length)/COUNT(length)AS 'SUM/COUNT' from film;

-- 10. Group choice 4#:
--BUSINESS QUESTION: Find how many customers are active and organize them by the originating store
--INPUT:
--SELECT store_id, COUNT(active)
--FROM customer WHERE active=1
--GROUP by store_id;

-- 11. Group choice 5#:
--BUSINESS QUESTION: How many films are out on rent
--INPUT:
--SELECT COUNT(inventory_id) as numOfDVDsOnRent
--FROM rental
--WHERE return_date IS NULL;

-- 12. Group Choice 6#:
--BUSINESS QUESTION: Finding ‘thrilling’ film in film description
--INPUT:
--SELECT title, description
--FROM film
--WHERE description LIKE '%thrilling%' limit 5;

-- 12 Group choice 7#:
--BUSINESS QUESTION: Can a customer rent a film over 3 hours at the cost of $00.99
--INPUT:
--SELECT film_id, title, rental_rate, length
--FROM film
--WHERE rental_rate = 00.99 AND length>180
--limit 5;

-- 13. Group Choice 8#:
--BUSINESS QUESTION: What are the return dates of movies rented in Onomichi, Japan (limit 5)
 --INPUT: 
 --SELECT customer_id, return_date, last_name, address, city, country FROM rental
 --JOIN customer using (customer_id)
 --JOIN address using (address_id)
 --JOIN city using (city_id)
 --JOIN country using (country_id)
 --where country = 'Brazil';
 --where country = 'Japan' and city = 'Onomichi';
 --limit 5;



--MAS work in progress o3_23_2021
--Select first_name,last_name FROM actor
--where first_name = "NICK"
--join actor_id using film_actor actor_id;
--join film_id using film film_id
--join film_id using inventory film_id
--join inventory_id using rental inventory_id
--join customer_id using customer customer_id
--join address_id using address address_id
--where postal_code = "2*"








-- 14. Reports to list the number of times each film was rented.  (List the film name, actors in the film and number of times the film has been rented)

--Select distinct first_name,last_name as Actor, f.title as Movie, count(f.film_id) as
--Count
--from actor as a
--left join film_actor fa on a.actor_id =
--fa.actor_id
--inner join film f on fa.film_id = f.film_id
--left join inventory i on f.film_id = i.film_id
--left join rental r on i.inventory_id = r.inventory_id
--group by a.actor_id, f.film_id   order by a.actor_id,f.film_id, Count desc

-- (Great Example of count & Sum) 15.	Report that list the name of the films, the number of times it has been rented and the total revenue the film has generated.  Also list the total of revenue all films have generated in the database.

--Input:
--select film.title, COUNT(*) AS "Number of Rentals", SUM(amount) AS "Total Revenue"
--from film INNER JOIN inventory ON film.film_id = inventory.film_id
    --INNER join rental ON inventory.inventory_id = rental.inventory_id
      --INNER JOIN payment ON rental.rental_id = payment.rental_id
--GROUP BY film.title;

-- 15. List the actors in alphabetical order according to their last names.
--Input: 
--SELECT last_name, first_name
 --FROM actor
 --ORDER BY last_name ASC;

-- 16. Give the total number of inactive customers.
--Input: 
--select active, first_name, last_name
--from customer
--where active = '0';
--select count(active)
--from customer
--where active = '0';
