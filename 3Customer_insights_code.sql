/*Creating Tables and Rows*/

create table country
(country_id int primary key,
 country_name varchar(50),
 head_office varchar(50));
 
insert into country
values
(1, 'UK', 'London'),
(2, 'USA', 'New York'),
(3, 'China', 'Beijing');

create table customers
( c_id int,
  first_shop date,
  age int,
  rewards varchar(50),
  can_email varchar(50)
  );
  
insert into customers
values 
(1, '2022-03-20', 23, 'yes', 'no'),
(2, '2022-03-25', 26, 'no', 'no'),
(3, '2022-04-06', 32, 'no', 'no'),
(4, '2022-04-13', 25, 'yes', 'yes'),
(5, '2022-04-22', 49, 'yes', 'yes'),
(6, '2022-06-18', 28, 'yes', 'no'),
(7, '2022-06-30', 36, 'no', 'no'),
(8, '2022-07-04', 37, 'yes', 'yes');

create table orders
(o_id int primary key,
 c_id int,
 date_shop date,
 sales_channel varchar(50),
 country_id int,
 Foreign key(c_id) references customers(c_id),
 foreign key(country_id) references country(country_id));
 
insert into orders
values
(1, 1, '2023-01-16', 'retail', 1),
(2, 4, '2023-01-20', 'retail', 1),
(3, 2, '2023-01-25', 'retail', 2),
(4, 3, '2023-01-25', 'online', 1),
(5, 1, '2023-01-28', 'retail', 3),
(6, 5, '2023-02-02', 'online', 1),
(7, 6, '2023-02-05', 'retail', 1),
(8, 3, '2023-02-11', 'online', 3);

create table product
(p_id int primary key,
 category varchar(50),
 price decimal(5,2)
 );
 
insert into product
values
(1, 'food', 5.99),
(2, 'sports', 12.49),
(3, 'vitamins', 6.99),
(4, 'food', 0.89),
(5, 'vitamins', 15.99);

create table basket
( o_id int,
  p_id int,
  foreign key (o_id) references orders(o_id),
  foreign key (p_id) references product(p_id));
  
insert into basket
values
(1, 1),
(1, 2),
(1, 5),
(2, 4),
(3, 3),
(4, 2),
(4, 1),
(5, 3),
(5, 5),
(6, 4),
(6, 3),
(6, 1),
(7, 2),
(7, 1),
(8, 3),
(8, 3);

/*QUESTIONS*/

/*1. What are the names of all the countries in the country table?*/
select distinct(country_name)
from country;

/*2. What is the total number of customers in the customers table?*/

select distinct(count(*)) as Number_of_customers
from customers;

/*3. What is the average age of customers who can receive marketing emails (can_email is set to 'yes')?*/

select age,can_email
from customers
where can_email='yes';

select round(avg(age),0)
from customers
where can_email='yes';

/*4. How many orders were made by customers aged 30 or older?*/

select count(*) as Number_Of_Orders_Made_By_Customers_Aged_30_or_more
from orders o
join customers c
using(c_id)
where c.age >=30
;

/*5. What is the total revenue generated by each product category?*/

select category,sum(price) as Revenue_For_each_Product
from product
group by category
order by Revenue_For_each_Product desc;

/*6. What is the average price of products in the 'food' category?*/

select category,round(avg(price),2)
from product
where category='food'
;

/*7. How many orders were made in each sales channel (sales_channel column) in the orders table?*/

select sales_channel,count(*) as Number_Of_Orders_in_Each_Channel
from orders
group by sales_channel;

/*8.What is the date of the latest order made by a customer who can receive marketing emails?*/

select max(if(can_email='yes',first_shop,'')) as Lastest_Order_Date
from customers;
                    
/*9. What is the name of the country with the highest number of orders?*/

select c.country_name,count(o.o_id) as Highest_number_of_Order
from orders o
join country c
using(country_id)
group by c.country_name
limit 1;

/*10. What is the average age of customers who made orders in the 'vitamins' product category?*/

/*Subquery*/
SELECT round(AVG(age),1) AS average_age
FROM customers
WHERE c_id IN (
    SELECT o.c_id
    FROM orders o
    JOIN basket b ON o.o_id = b.o_id
    JOIN product p ON b.p_id = p.p_id
    WHERE p.category = 'vitamins'
);































