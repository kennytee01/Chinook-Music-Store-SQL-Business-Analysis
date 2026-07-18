-- Business Question
--Purchasing behavior
-- (e.g., avg order value, orders per customer, or purchases by country)

select c.customer_id, c.first_name, c.last_name, c.country,
       count(i.invoice_id) as order_count,
       round(avg(i.total), 2) as avg_order_value,
       round(sum(i.total), 2) as total_spent
from invoice i
join customer c on i.customer_id = c.customer_id
group by c.customer_id, c.first_name, c.last_name, c.country
order by order_count desc, total_spent desc
limit 15;

/************************
Insight: The USA generates the highest total revenue ($523.06) simply due to 
having the largest customer base (13 customers), 
not because of higher spend per customer.
On a revenue-per-customer basis, Czech Republic ($45.12) and Chile ($46.62)
outperform the USA ($40.24), though these figures are based on only 
1–2 customers each and should be treated as directional rather than 
statistically reliable. The consistent 7-orders-per-customer ratio across 
every country confirms this is a uniform, non-behavioral spend pattern rather 
than a market-specific trend — any "expand into Czech Republic/Chile" 
recommendation would need a larger sample before being actionable.
*****/

select c.country,
       count(distinct c.customer_id) as customer_count,
       count(i.invoice_id) as total_orders,
       round(sum(i.total), 2) as total_revenue,
       round(sum(i.total) / count(distinct c.customer_id), 2) as revenue_per_customer
from invoice i
join customer c on i.customer_id = c.customer_id
group by c.country
order by total_revenue desc
limit 10;

/*******************
Insight: All customers in the dataset show an identical order count of 7,
meaning customer ranking by total spend is driven entirely by average order value
rather than purchase frequency.
Combined with the flat monthly revenue pattern identified earlier,
this confirms the dataset simulates transaction volume uniformly across customers
rather than reflecting organic purchasing behavior.
In a real dataset, this finding would normally prompt 
a "increase orders per customer" recommendation — here,
the more accurate takeaway is that average order value is the only meaningful
lever this data can support for differentiating customer value.


