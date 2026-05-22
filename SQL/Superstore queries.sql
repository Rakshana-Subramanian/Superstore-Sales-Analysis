----------------------------------------------------
-- PROJECT : Superstore DATA ANALYSIS
-- AUTHOR  : RAKSHANA SUBRAMANIAN
-- TOOL    : ORACLE SQL
-- DATE    : MAY 2026
-----------------------------------------------------

-- Find total sales and profit for each region
Select region, round(sum(sales),0) as Total_sales,round(sum(profit),0) as Total_profit from superstore_data group by region;

-- Find Total sales for each category ordered by highest sales
Select category,round(sum(sales),0) as Total_sales from superstore_data group by category order by sum(sales) desc;

-- Find top 10 customers by total sales
Select Customer_name, round(sum(sales),0) as total_sales from superstore_data group by customer_name order by total_sales desc fetch first 10 rows only;

-- Find total numbers of orders per shid mode
select ship_mode,count(order_id) as total_number_of_orders from superstore_data group by ship_mode;

-- Find all orders where discount is greater than 0.5
select count(*) as Total_orders from superstore_data where discount>0.5;

-- Find sub-categories where total profit is negative(loss making)
select sub_category,round(sum(profit),0) from superstore_data group by sub_category having sum(profit)<0;

-- Find monthly sales trend for all years
select to_char(order_date,'YYYY-MM') as Month,round(sum(sales),0)as total_sales from superstore_data group by to_char(order_date,'YYYY-MM') order by month;

Alter table superstore_data rename column segment to cus_segment;

-- Find customer segment with highest total profit
select cus_Segment, round(sum(profit),0) as Highest_profit from superstore_data group by cus_segment order by Highest_profit desc;

-- Find top 5 states by total sales
select state,round(sum(sales),0) as Total_sales from superstore_data group by state order by Total_sales desc fetch first 5 rows only;

-- Find average profit for each category where average profit is greater than 50
select category,round(avg(profit),2) from superstore_data group by category having avg(profit)>50;

-- Find customers whose total sales is more than average sales
select customer_name,round(sum(sales),0) as total_sales from superstore_data group by customer_name having sum(Sales)>(select avg(total_sales) from(select sum(Sales) as total_sales from superstore_data group by customer_name));

-- Find products with sales above average;
select product_name, round(sales,0) as Sales from superstore_data where sales>(select avg(sales) from superstore_data) order by sales desc;

-- Rank region by Total sales
select region,round(sum(sales),0) as total_sales, rank() over(order by sum(sales) desc) as rank from superstore_data group by region;

-- Top 3 customers per region
select * from(select region,customer_name,round(sum(sales),0) as total_sales, rank() over(partition by region order by sum(Sales) desc) as rnk from superstore_data group by region,customer_name) where rnk<=3 order by region,rnk;


