
use pizza_db;

select * from pizza_sales;

-- revenue 

select floor(sum(total_price)) as total_revenue from pizza_sales;

-- avg. order value

select floor(sum(total_price)/COUNT(Distinct order_id) ) as "avg order value" from pizza_sales;

-- total pizza sold 

select Sum(quantity) as "total_pizza_sold" from pizza_sales;

-- total order

select Count(Distinct order_id) as "total_orders" from pizza_sales;

-- avg. pizza per order

select sum(quantity) / count(distinct order_id) as "Avg_piza" from pizza_sales;

-- daily trend of order

select datename(DW,order_date) as "order_day" , count(distinct order_id) as order_value from pizza_sales group by datename(DW,order_date)
order by count(distinct order_id) Desc;

-- daily trend of revnue by days .

select datename(DW,order_date) as "order_day" , floor(sum(total_price)) as revnue from pizza_sales group by datename(DW,order_date)
order by sum(total_price) Desc;

-- Monthly tred of avg. order value

select datename(MONTH,order_date) as "order_Month" , count(distinct order_id) as order_value from pizza_sales group by datename(MONTH,order_date)
order by count(distinct order_id) Desc;

--% of sales by pizza category

select pizza_category ,sum(total_price) as total_sales, sum(total_price) * 100/ (Select sum(total_price) 
from pizza_sales where MONTH(order_date) = 1 ) as PCT from pizza_sales where MONTH(order_date) = 1 
group by pizza_category ;

--% of sales by pizza_size 

select pizza_size ,sum(total_price) as total_sales, sum(total_price) * 100/ (Select sum(total_price) 
from pizza_sales where MONTH(order_date) = 1 ) as PCT from pizza_sales where MONTH(order_date) = 1 
group by pizza_size ;

-- total pizza sold by pizza cat.

select pizza_category, sum(quantity) as "Pizza sold " from pizza_sales group by pizza_category order by sum(quantity) desc ;

-- top 5 best seller by revenue , total Quantity and total orders 

select top 5 pizza_name ,sum(total_price) as "total_price" from pizza_sales  group by pizza_name order by sum(total_price) desc;

select top 5 pizza_name ,sum(quantity) as "total_quantity" from pizza_sales  group by pizza_name order by sum(quantity) desc;

select top 5 pizza_name ,count(distinct order_id) as "total_orders" from pizza_sales  group by pizza_name order by count(distinct order_id) desc;

--bottom 5 best seleers by revenue , total Quantity and total orders  

select top 5 pizza_name ,sum(total_price) as "total_price" from pizza_sales  group by pizza_name order by sum(total_price) ;

select top 5 pizza_name ,sum(quantity) as "total_quantity" from pizza_sales  group by pizza_name order by sum(quantity);

select top 5 pizza_name ,count(distinct order_id) as "total_orders" from pizza_sales  group by pizza_name order by count(distinct order_id) ;

