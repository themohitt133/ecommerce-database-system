create table Users(
user_id serial primary key,
name varchar(50),
email varchar(50),
city varchar(50),
signup_date date
);


create table Products(
product_id serial primary key,
product_name varchar(50),
category varchar(50),
price numeric(10,2),
stock int
);


create table Orders(
order_id serial primary key,
user_id int references Users(user_id),
product_id int references Products(product_id),
quantity int,
order_date date
);


create table Payments(
payment_id serial primary key,
order_id int references Orders(order_id),
payment_method varchar(50),
payment_status varchar(50),
amount numeric(10,2),
payment_date date
);


insert into Users (user_id, name, email, city, signup_date) values
(1,'Aarav Sharma','aarav@gmail.com','Delhi','2025-01-05'),
(2,'Priya Singh','priya@gmail.com','Lucknow','2025-01-12'),
(3,'Rahul Verma','rahul@gmail.com','Mumbai','2025-01-18'),
(4,'Ananya Gupta','ananya@gmail.com','Jaipur','2025-02-01'),
(5,'Rohan Yadav','rohan@gmail.com','Kanpur','2025-02-05'),
(6,'Sneha Patel','sneha@gmail.com','Ahmedabad','2025-02-14'),
(7,'Mohit Pal','mohit@gmail.com','Bareilly','2025-02-20'),
(8,'Neha Sharma','neha@gmail.com','Delhi','2025-03-02'),
(9,'Vikas Kumar','vikas@gmail.com','Patna','2025-03-09'),
(10,'Pooja Mishra','pooja@gmail.com','Prayagraj','2025-03-18'),
(11,'Arjun Mehta','arjun@gmail.com','Pune','2025-03-22'),
(12,'Karan Singh','karan@gmail.com','Noida','2025-04-01'),
(13,'Simran Kaur','simran@gmail.com','Chandigarh','2025-04-06'),
(14,'Ritika Jain','ritika@gmail.com','Indore','2025-04-11'),
(15,'Aditya Roy','aditya@gmail.com','Kolkata','2025-04-18'),
(16,'Nisha Gupta','nisha@gmail.com','Bhopal','2025-05-02'),
(17,'Sahil Khan','sahil@gmail.com','Hyderabad','2025-05-09'),
(18,'Kavya Sharma','kavya@gmail.com','Delhi','2025-05-15'),
(19,'Aman Tiwari','aman@gmail.com','Varanasi','2025-05-20'),
(20,'Meera Joshi','meera@gmail.com','Nagpur','2025-06-01');



insert into Products (product_id, product_name, category, price, stock) values
(101,'Laptop','Electronics',65000,20),
(102,'Smartphone','Electronics',25000,35),
(103,'Keyboard','Electronics',1500,80),
(104,'Mouse','Electronics',800,100),
(105,'Headphones','Electronics',2500,60),
(106,'Smart Watch','Wearables',5000,40),
(107,'Backpack','Accessories',1800,50),
(108,'Water Bottle','Home',500,120),
(109,'Office Chair','Furniture',7000,15),
(110,'Study Table','Furniture',9000,10),
(111,'Notebook','Stationery',120,300),
(112,'Pen Pack','Stationery',100,250),
(113,'Monitor','Electronics',14000,18),
(114,'USB Drive','Electronics',900,90),
(115,'Power Bank','Electronics',1800,45);


insert into orders (order_id,user_id,product_id,quantity,order_date) values
(1001,1,101,1,'2025-01-10'),
(1002,2,103,2,'2025-01-15'),
(1003,3,102,1,'2025-01-20'),
(1004,4,111,5,'2025-02-02'),
(1005,5,105,2,'2025-02-07'),
(1006,6,109,1,'2025-02-15'),
(1007,7,106,1,'2025-02-21'),
(1008,8,114,3,'2025-03-03'),
(1009,9,102,1,'2025-03-09'),
(1010,10,110,1,'2025-03-18');

insert into payments(payment_id,order_id,payment_method,payment_status,amount,payment_date)
values
(5001,1001,'UPI','Completed',65000,'2025-01-10'),
(5002,1002,'Card','Completed',3000,'2025-01-15'),
(5003,1003,'Net Banking','Completed',25000,'2025-01-20'),
(5004,1004,'UPI','Completed',600,'2025-02-02'),
(5005,1005,'Cash on Delivery','Completed',5000,'2025-02-07'),
(5006,1006,'Card','Completed',7000,'2025-02-15'),
(5007,1007,'UPI','Completed',5000,'2025-02-21'),
(5008,1008,'Card','Completed',2700,'2025-03-03'),
(5009,1009,'UPI','Completed',25000,'2025-03-09'),
(5010,1010,'Net Banking','Completed',9000,'2025-03-18');

select * from Users;
select * from Products;
select * from Orders;
select * from Payments;
