create database retail_sales;
use retail_sales;

create table customers(customer_id int primary key auto_increment,name varchar(255) not null,city varchar(100) not null);

create table Products(product_id int primary key auto_increment,name varchar(200) not null,category varchar(255) not null,price decimal(10,2) not null);

create table orders(order_id int primary key auto_increment,customer_id int not null,date date not null,foreign key(customer_id) references Customers(customer_id));

create table order_items(order_id int not null,product_id int not null,quantity int not null default 1,primary key (order_id,product_id) , foreign key(order_id) references orders(order_id),foreign key(product_id) references Products(product_id));


INSERT INTO Customers (name, city) VALUES
('Aarav Sharma',    'Chennai'),
('Bhavna Reddy',    'Hyderabad'),
('Chetan Iyer',     'Bangalore'),
('Divya Nair',      'Mumbai'),
('Elan Murugan',    'Chennai'),
('Farhan Sheikh',   'Delhi'),
('Geetha Pillai',   'Kochi'),
('Harish Verma',    'Pune'),
('Isha Kapoor',     'Mumbai'),
('Janaki Raman',    'Chennai'),
('Karan Mehta',     'Delhi'),
('Lavanya Suresh',  'Bangalore'),
('Manoj Kumar',     'Hyderabad'),
('Nithya Balaji',   'Chennai'),
('Om Prakash',      'Jaipur');


INSERT INTO Products (name, category, price) VALUES
('Samsung Galaxy S24',      'Electronics',  74999.00),
('Apple AirPods Pro',       'Electronics',  24999.00),
('Sony WH-1000XM5',         'Electronics',  29999.00),
('Nike Air Max 270',        'Footwear',     8999.00),
('Puma Running Shoes',      'Footwear',     4999.00),
('Adidas Ultraboost',       'Footwear',     12999.00),
('The Alchemist (Book)',     'Books',        350.00),
('Atomic Habits (Book)',     'Books',        499.00),
('Rich Dad Poor Dad',       'Books',        299.00),
('Whirlpool Microwave',     'Appliances',   8499.00),
('Prestige Pressure Cooker','Appliances',   2199.00),
('Philips Air Fryer',       'Appliances',   6499.00);


INSERT INTO Orders (customer_id, date) VALUES
(1,  '2025-01-05'),   
(2,  '2025-01-12'),   
(3,  '2025-01-20'),   
(1,  '2025-02-03'),   
(4,  '2025-02-14'),  
(5,  '2025-02-18'),   
(6,  '2025-02-25'),   
(7,  '2025-03-01'),   
(8,  '2025-03-10'),   
(9,  '2025-03-15'),   
(10, '2025-03-22'),   
(2,  '2025-03-28'),   
(11, '2025-04-01'),   
(12, '2025-04-05'),   
(3,  '2025-04-08'),   
(13, '2025-04-10'),   
(1,  '2025-04-12'),   
(14, '2025-04-15'),  
(5,  '2025-04-18'),   
(6,  '2025-04-20'); 



INSERT INTO Order_Items (order_id, product_id, quantity) VALUES
(1,  1, 1),   
(1,  2, 2),  
(2,  4, 1),   
(2,  7, 3),  
(3,  3, 1),   
(3,  8, 1),   
(4,  6, 1),   
(4,  10,1),  
(5,  1, 1),   
(5,  11,2),   
(6,  5, 1),   
(6,  9, 2),   
(7,  2, 1),  
(7,  12,1),   
(8,  1, 2),   
(8,  3, 1),   
(9,  4, 1),   
(9,  7, 2),   
(10, 6, 1),   
(10, 8, 1),  
(11, 10,1),   
(11, 11,1),   
(12, 2, 3),   
(12, 5, 1),   
(13, 1, 1),   
(13, 12,2),   
(14, 3, 1),  
(14, 9, 1),
(15, 6, 2),   
(15, 8, 3),   
(16, 4, 1),   
(16, 10,1),   
(17, 1, 1),   
(17, 2, 1),   
(18, 7, 4),   
(18, 11,1),   
(19, 3, 1),  
(19, 5, 2),   
(20, 12,1),   
(20, 6, 1);   


SELECT p.product_id,p.name,p.price,SUM(ord_i.quantity * p.price) AS total_revenue FROM order_items ord_i JOIN products p ON p.product_id = ord_i.product_id GROUP BY p.product_id;

select p.product_id ,p.name ,sum(ord_i.quantity) as total_quatity from order_items ord_i join products p on p.product_id = ord_i.product_id group by p.product_id;

select c.customer_id,c.name,c.city,sum(ord_i.quantity * p.price) as total_value ,count(distinct o.order_id) from customers c inner join  orders o on c.customer_id = o.customer_id inner join order_items ord_i 
on o.order_id = ord_i.order_id inner join products p on p.product_id = ord_i.product_id group by c.name,c.customer_id,c.city order by total_value desc limit 5;

select  month(o.date) as month_num , monthname(o.date) as month_name,count(distinct o.order_id) as total_orders_per_month,sum(p.price * ord_id.quantity) as Montly_rev from orders o join
order_items ord_id on ord_id.order_id = o.order_id join products p on ord_id.product_id =p.product_id group by month(o.date),monthname(o.date);  


SELECT p.category,COUNT(DISTINCT p.product_id)   AS products_in_category,SUM(ord_id.quantity) AS total_units_sold,SUM(ord_id.quantity * p.price) AS category_revenue,
ROUND(SUM(ord_id.quantity * p.price) * 100.0 /
        (SELECT SUM(oi2.quantity * p2.price)
         FROM Order_Items oi2
         JOIN Products p2 ON oi2.product_id = p2.product_id), 2
    )AS revenue_percentage
FROM Order_Items ord_id
JOIN Products p ON ord_id.product_id = p.product_id
GROUP BY p.category
ORDER BY category_revenue DESC;



select c.customer_id ,c.name as cust_name , c.city ,'No Orders' as status from customers c left join orders o on c.customer_id = o.customer_id where o.order_id is null;

select c.city,c.name,count(distinct o.order_id) as total_orders,sum(ord_id.quantity * p.price) as cty_revenue from customers c inner join orders o on c.customer_id = o.customer_id inner join 
order_items ord_id on ord_id.order_id  = o.order_id inner join products p on p.product_id = ord_id.product_id group by c.city,c.name order by cty_revenue desc;


select round(sum(ord_id.quantity * p.price) / count(distinct o.order_id),2)  as avg_order_val from order_items ord_id inner join orders o on ord_id.order_id  = o.order_id inner join products p on p.product_id = ord_id.product_id;

select c.customer_id ,c.name as customer_name ,c.city,count(distinct o.order_id) as order_count from orders o inner join customers c on c.customer_id = o.customer_id group by c.name,c.customer_id having count(o.order_id >1) order by order_count desc;