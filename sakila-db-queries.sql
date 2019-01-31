

use sakila;


-- 1a. Display the first and last names of all actors from the table actor.
select first_name, last_name 
from actor;


-- 1b. Display the first and last name of each actor in a single column in upper case letters. Name the column Actor Name.
select upper(concat(first_name, ' ', last_name))   'Actor Name'
from actor;

-- 2a. You need to find the ID number, first name, and last name of an actor, of whom you know only the first name, "Joe." What is one query would you use to obtain this information?
select actor_id, first_name, last_name 
from actor 
where lower(first_name) = lower("Joe");

-- 2b. Find all actors whose last name contain the letters GEN:
select * 
from actor 
where upper(last_name) like '%GEN%';


-- 2c. Find all actors whose last names contain the letters LI. This time, order the rows by last name and first name, in that order:
select * 
from actor 
where upper(last_name) like '%LI%' 
order by last_name, first_name;


-- 2d. Using IN, display the country_id and country columns of the following countries: Afghanistan, Bangladesh, and China:
select country_id, country 
from country 
where country in ('Afghanistan', 'Bangladesh', 'China');


-- 3a. You want to keep a description of each actor. You don't think you will be performing queries on a description, so create a column in the table actor named description and use the data type BLOB (Make sure to research the type BLOB, as the difference between it and VARCHAR are significant).

select * from actor;

ALTER TABLE actor
ADD COLUMN description BLOB;

select * from actor;

-- 3b. Very quickly you realize that entering descriptions for each actor is too much effort. Delete the description column.

select * from actor;

alter table actor
drop column description;

select * from actor;

-- 4a. List the last names of actors, as well as how many actors have that last name.

select last_name, count(*) actor_count 
from actor 
group by last_name
order by actor_count desc, last_name;

select count(*) from (
	select last_name, count(*) actor_count 
	from actor 
	group by last_name
) result;


-- 4b. List last names of actors and the number of actors who have that last name, but only for names that are shared by at least two actors
select last_name, count(*) actor_count 
from actor 
group by last_name
having actor_count >1
order by actor_count desc, last_name;

select count(*) from (
	select last_name, count(*) actor_count 
	from actor 
	group by last_name
	having actor_count >1
) result;

-- 4c. The actor HARPO WILLIAMS was accidentally entered in the actor table as GROUCHO WILLIAMS. Write a query to fix the record.

select * from actor where first_name = 'GROUCHO' and last_name = 'WILLIAMS';

update actor set first_name = 'HARPO', last_name = 'WILLIAMS' where first_name = 'GROUCHO' and last_name = 'WILLIAMS';

select * from actor where last_name = 'WILLIAMS';



-- 4d. Perhaps we were too hasty in changing GROUCHO to HARPO. It turns out that GROUCHO was the correct name after all! In a single query, if the first name of the actor is currently HARPO, change it to GROUCHO.

update actor set first_name = 'GROUCHO', last_name = 'WILLIAMS' where first_name = 'HARPO' and last_name = 'WILLIAMS';

select * from actor where last_name = 'WILLIAMS';

-- 5a. You cannot locate the schema of the address table. Which query would you use to re-create it?
-- Hint: https://dev.mysql.com/doc/refman/5.7/en/show-create-table.html

SHOW CREATE TABLE address;


-- 6a. Use JOIN to display the first and last names, as well as the address, of each staff member. Use the tables staff and address:


select stf.first_name, stf.last_name, adr.address, adr.district, adr.postal_code, adr.city_id 
from staff stf
left join address adr
on stf.address_id = adr.address_id;


-- 6b. Use JOIN to display the total amount rung up by each staff member in August of 2005. Use tables staff and payment.

select stf.first_name, stf.last_name, sum(pay.amount)
from staff stf
left join payment pay
on stf.staff_id = pay.staff_id
WHERE month(pay.payment_date) = 8
and year(pay.payment_date)  = 2005
group by stf.first_name, stf.last_name;



-- 6c. List each film and the number of actors who are listed for that film. Use tables film_actor and film. Use inner join.

select flm.title, count(*) number_of_actors
from film flm
inner join film_actor fim_act
on flm.film_id = fim_act.film_id
group by flm.title
order by number_of_actors desc;




-- 6d. How many copies of the film Hunchback Impossible exist in the inventory system?

select flm.title, count(*) number_in_inventory
from film flm
inner join inventory inv
on flm.film_id = inv.film_id
where lower(flm.title) = lower('Hunchback Impossible')
group by flm.title;


-- 6e. Using the tables payment and customer and the JOIN command, list the total paid by each customer. List the customers alphabetically by last name:

select cust.first_name, cust.last_name, sum(pay.amount) 'Total Amount Paid' 
from payment pay
join customer cust
on pay.customer_id = cust.customer_id
group by cust.first_name, cust.last_name
order by cust.last_name;


-- 7a. The music of Queen and Kris Kristofferson have seen an unlikely resurgence. As an unintended consequence, films starting with the letters K and Q have also soared in popularity. Use subqueries to display the titles of movies starting with the letters K and Q whose language is English.


-- 7b. Use subqueries to display all actors who appear in the film Alone Trip.


-- 7c. You want to run an email marketing campaign in Canada, for which you will need the names and email addresses of all Canadian customers. Use joins to retrieve this information.


-- 7d. Sales have been lagging among young families, and you wish to target all family movies for a promotion. Identify all movies categorized as family films.


-- 7e. Display the most frequently rented movies in descending order.


-- 7f. Write a query to display how much business, in dollars, each store brought in.


-- 7g. Write a query to display for each store its store ID, city, and country.


-- 7h. List the top five genres in gross revenue in descending order. (Hint: you may need to use the following tables: category, film_category, inventory, payment, and rental.)


-- 8a. In your new role as an executive, you would like to have an easy way of viewing the Top five genres by gross revenue. Use the solution from the problem above to create a view. If you haven't solved 7h, you can substitute another query to create a view.


-- 8b. How would you display the view that you created in 8a?


-- 8c. You find that you no longer need the view top_five_genres. Write a query to delete it.