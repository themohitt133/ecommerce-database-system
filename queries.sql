--              ....... BASIC QUERIES ........      --

-- 1. Display all users.

select * from Users;

--2. Display selectec columns.

select user_id , name , city 
from users;

-- 3. Find users from a specific city.

select * from users
where city = 'Delhi';

-- 4. Find products with price greater than 1000.

select * from products
where price > 1000;

-- 5. Find orders placed after a specific date.

select * from orders 
where order_date = '2025-01-10';

-- 6. Find users from Delhi or Mumbai.

select * from users
where city in ('Delhi','Mumbai');

-- 7. Search products starting with "S".

select * from products
where product_name like 'S%';

-- 8. Display products sorted by price(high to low).

select * from products
order by price desc;

-- 9. Show first 5 products.

select * from products
limit 5;

-- 10. Display unique cities.

select distinct city
from users;


--              ....... INTERMEDIATE QUERIES ........      --

-- 11. Display customer name with order details.

select o.order_id,u.name,p.product_name,o.quantity,o.order_date
from orders o
inner join users u on o.user_id=u.user_id
inner join products p on o.product_id=p.product_id;

-- 12. Display all users and their orders.

select u.user_id,u.name,o.order_id,o.order_date
from users u
left join orders o on u.user_id=o.user_id;

-- 13. Count total orders placed by each user.

select u.user_id,u.name,
count(o.order_id) as total_orders
from users u
left join orders o
on u.user_id=o.user_id
group by u.user_id,u.name
order by user_id;

-- 14. Calculate total revenue.

select sum(amount) as total_revenue
from payments;

-- 15. Calculate avg product price.

select avg(price) as avg_price
from products;

-- 16. Find Highest and Lowest Product Price. (*)

select max(price) as highest_price,
       min(price) as lowest_price
	   from products;

-- 17. Display Num of users in Each City. (*)

select city,
count(user_id) as total_users
from users
group by city
order by total_users desc;

-- 18. Display Cities Having More than One Users.

select city,
count(user_id) as total_users
from users
group by city
having count(user_id) > 1;

-- 19. Display payments details with Customer Name. (*)

select p.payment_id,u.name,p.payment_method,p.payment_status,p.amount
from payments p
inner join orders o
on p.order_id=o.order_id
inner join users u
on o.user_id=u.user_id;

-- 20. Display Complete Order Details. (**)

select o.order_id,u.name,pr.product_name,
       pr.category,o.quantity,p.payment_method,
	   p.payment_status,p.amount
from orders o
inner join users u
on o.user_id=u.user_id
inner join products pr
on o.product_id =pr.product_id
inner join payments p
on o.order_id=p.order_id;



--              ....... ADVANCED QUERIES ........           --


-- 21. Customers Who Placed atleast One Order.

select * from users
where user_id 
in(select user_id from orders);

-- 22. Product Never Ordered.

select * from products
where product_id 
not in(select product_id from orders);

-- 23. Customers Who Spent More than 10000.

select name from users
where user_id in
(select o.user_id
from orders o inner join payments p
on o.order_id=p.order_id
group by o.user_id
having sum(p.amount) > 10000
);

-- 24. Revenue by Payment Method (CTE)

with payment_summary as (
select payment_method,sum(amount) as
total_revenue from payments
group by payment_method
)
select * from payment_summary;

-- 25. Rank Customers by Spending.

select u.name,
sum(p.amount) as total_spent,
rank() over(order by sum(p.amount) desc) as customer_rank
from users u
join orders o
on u.user_id=o.user_id
join payments p
on o.order_id=p.order_id
group by u.user_id,u.name;

-- 26. Dense Rank Customers by Spending.

select u.name,
sum(p.amount) as total_spent,
dense_rank() over(order by sum(p.amount) desc) as customer_rank
from users u
join orders o
on u.user_id=o.user_id
join payments p
on o.order_id=p.order_id
group by u.user_id,u.name;

-- 27. Display Payment Status Using CASE.

select payment_id,amount,
case 
when payment_status='Completed' then 'Success'
else 'Failed'
end as payment_result
from payments;

-- 28. Running Total Revenue.

select payment_date,amount,
sum(amount) over(order by payment_date)
as running_revenue 
from payments;

-- 29. Row Num Based on Highest Payment.

select payment_id,amount,
row_number() over(order by amount desc) as row_num
from payments;

-- 30. Monthly Revenue Report. (***)

with monthly_revenue as(
select date_trunc('month',payment_date) as month,
sum(amount) as revenue from payments
group by date_trunc('month',payment_date)
)
select * from monthly_revenue
order by month;



--              ....... BUSINESS ANALYSIS ........           --

-- 1. Total Revenue.

select sum(amount) 
as total_revenue
from payments;

-- 2. Monthly Revenue.

select date_trunc('month',payment_date) as month,
sum(amount) as revenue
from payments
group by date_trunc('month',payment_date)
order by month;

-- 3. Revenue by Category.

select p.category,
sum(pay.amount) as revenue
from products p
join orders o
on p.product_id=o.product_id
join payments pay
on pay.order_id=o.order_id
group by p.category
order by revenue desc;

-- 4. Revenue by Payment Method.

select payment_method,
sum(amount) as revenue
from payments
group by payment_method
order by revenue desc;

-- 5. Top 5 Selling Product.

select p.product_name,
sum(o.quantity) as total_sold
from products p
join orders o
on p.product_id=o.product_id
group by p.product_name
order by total_sold desc
limit 5;

-- 6. Lowest Selling Products.

select p.product_name,
sum(o.quantity) as total_sold
from products p
join orders o
on o.product_id = p.product_id
group by p.product_name
order by total_sold;

-- 7. Top Customers by Spending.

select u.name,
sum(p.amount) as total_spent
from users u
join orders o
on o.user_id=u.user_id
join payments p
on o.order_id=p.order_id
group by u.name
order by total_spent desc
limit 5;

-- 8. Avg Order Value.

select avg(amount) as avg_order_value
from payments;

-- 9. Most Popular Category.

select p.category,
sum(o.quantity) as total_qty
from products p
join orders o
on o.product_id=p.product_id
group by p.category
order by total_qty desc
limit 1;

-- 10. City-wise Revenue.

select u.city,
sum(p.amount) as revenue
from users u
join orders o
on o.user_id=u.user_id
join payments p
on p.order_id=o.order_id
group by u.city
order by revenue desc;

-- 11. Daily Sales Trend.

select payment_date,
sum(amount) as daily_sales
from payments
group by payment_date
order by daily_sales desc;

-- 12. Customers with NO Orders.

select u.user_id,u.name
from users u
left join orders o
on o.user_id=u.user_id
where o.order_id is null;

-- 13. Products Never Ordered.

select p.product_name
from products p
left join orders o
on o.product_id=p.product_id
where o.order_id is null;

-- 14. Successful vs Failed Payments.

select payment_status,
count(*) as total_payments
from payments
group by payment_status;

-- 15. Best Selling Month. (*)

select date_trunc('month',payment_date) as month,
sum(amount) as revenue
from payments
group by date_trunc('month',payment_date)
order by revenue desc
limit 1;
