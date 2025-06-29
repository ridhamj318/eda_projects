select payment_method, count(*) from walmart group by payment_method

select count(Distinct Branch) from walmart

select min(Quantity) from walmart

--Business Problems
--Q1. find different payment method and number of transaction, number of qty sold
select top 5 * from walmart
select payment_method, sum(quantity) as qty, count(*) as no_payments from walmart group by payment_method

-- q2. Identify the highest - rated category in each branch, displaying the branch, category
-- Avg Rating

select * from (
	select branch, category, avg(rating) as avg_rate,
	Rank() over(partition by branch order by avg(rating) Desc) as rank
	from walmart
	group by Branch,category
) as t where rank = 1
--q4. calculate the total quantity sold per payment method. List payment_method ans total_quNTITY

select payment_method, count(*) from walmart group by payment_method

--q5. determine the acerage, minimum  and maximum rating of category for each city.
--list the city, average_rating, min_rating, and max_rating

select * from walmart
select city, Category, avg(rating) as avg_rating, max(rating) as mrate, min(rating) as min_rate from walmart group by city,Category

--q.6 Calculate the total profit for each category by considering total_profit
--as unit_price * quantity * profit_margin) list category and total_profit from highest to lowest profit

select
category, sum(total * profit_margin) as profit, sum(total) as total_revenue from walmart 
group by category

--q7. determine the most common payment method for each branch.
--Displayed branch and preferred branch

with cte as (select branch, payment_method, count(*) as total_trans,
rank() over(partition by branch order by count(*) desc) as rank from walmart 
group by branch, payment_method )
select * from cte where rank = 1

--q8.which branch generates tge highest total revenue, and by how much compared to others ?
select * from walmart

select branch, City, sum(unit_price * quantity) as total_revenue,
max(sum(unit_price * quantity)) over() as top_branch_revenue,
max(sum(unit_price * quantity)) over() - sum(unit_price * quantity) as revenue_difference
from walmart 
group by branch, City order by total_revenue desc

select branch, City,
sum(unit_price * quantity) as top_revnue,
max(sum(unit_price * quantity)) over() as max_top_revnue
from walmart
group by branch, City order by top_revnue, max_top_revnue desc

---Which product category contributes the most to revenue in all branches?
with cte as (select branch,category,
sum(unit_price * quantity) as revenue,
rank() over(partition by branch order by sum(unit_price * quantity) desc) as rank
from walmart
group by branch,category)
select * from cte where rank = 1

---Which product category contributes the most to revenue among all branches?
SELECT category,
SUM(unit_price * quantity) AS total_revenue
FROM walmart
GROUP BY category
ORDER BY total_revenue DESC;

--What is the average order value per transaction in each city or branch?
select City,Branch,
count(distinct invoice_id) as total_transaction,
sum(unit_price * quantity) as total_sales,
round(sum(unit_price * quantity) * 1.0 / count(distinct invoice_id), 2) as avg_order_value
from walmart
group by City,Branch
order by avg_order_value desc

--Which city has the highest profit margin, and which one needs improvement?
select * from walmart
select City, sum(profit_margin) as total_profit_margin from walmart group by City order by total_profit_margin desc

--Which branch has the lowest average customer rating,
select City, Branch, sum(rating) as customer_total_rating from walmart group by City, Branch order by customer_total_rating

--Which product category sells the most by quantity and by revenue?
select category, sum(unit_price * quantity) as revenue, sum(quantity) as total_quantity
from walmart group by category order by revenue, total_quantity desc

--What is the average profit margin per category, and which one is the most profitable?
select category, round(avg(profit_margin), 2) as avg_profit_margin from walmart group by category order by avg_profit_margin

--Is there a relationship between customer ratings and payment method or product category?
select category, payment_method, Count(*) as total_transaction , round(avg(rating),2) as avg_rating 
from walmart group by category, payment_method order by avg_rating desc

--Are customers spending more during specific hours of the day ?
select 
DATEPART(Hour, [time]) as hour_of_day,
count(*) as total_transaction
from walmart
group by DATEPART(Hour, [time])
order by total_transaction desc

select 
Datename(WEEKDAY, [date]) as day_of_week,
count(*) as total_transaction
from walmart 
where ISDATE([date]) = 1
group by Datename(WEEKDAY, [date])
order by total_transaction desc

--Which branch has the lowest average customer rating, and is there a pattern in those ratings (e.g., time of day, payment method)?
select
Branch,
ROUND(avg(rating),2) as avg_rating,
count(*) as total_reviews
from walmart
group by Branch
order by ROUND(avg(rating),2) desc;

select
Branch,
payment_method,
round(avg(rating), 2) as avg_rating,
count(*) as total_transaction
from walmart
where branch = 'WALM004'
group by Branch, payment_method
order by avg_rating asc

--Is there a difference in sales trends on different on weekends vs weekdays ?
select
	Case
		when DATENAME(weekday, [date]) in ('Saturday' , 'Sunday') then 'weekend'
		else 'weekday'
	end as day_type,
	count(*) as total_transaction,
	sum(total) as total_sales,
	ROUND(avg(total),2) as avg_sales_per_transaction
from walmart 
where ISDATE([date]) = 1
group by
	Case
		when DATENAME(weekday, [date]) in ('Saturday' , 'Sunday') then 'weekend'
		else 'weekday'
	end
	
--Is there a difference in sales trends on different on weekends vs weekdays ?
select
Branch,
	Case
		when DATENAME(weekday, [date]) in ('Saturday' , 'Sunday') then 'weekend'
		else 'weekday'
	end as day_type,
	count(*) as total_transaction,
	sum(total) as total_sales,
	ROUND(avg(total),2) as avg_sales_per_transaction
from walmart 
where ISDATE([date]) = 1
group by
Branch,
	Case
		when DATENAME(weekday, [date]) in ('Saturday' , 'Sunday') then 'weekend'
		else 'weekday'
	end
order by
	Branch