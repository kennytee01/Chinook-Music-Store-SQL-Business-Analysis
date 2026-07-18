-- Business Questions
--1. Top-spending customers

select c.customer_id, c.first_name, c.last_name, c.country,
       sum(i.total) as total_spent
from invoice i
join customer c on i.customer_id = c.customer_id
group by c.customer_id, c.first_name, c.last_name, c.country
order by total_spent desc
limit 10;

/******
Insight: The top 10 customers by total spend range narrowly from $42.62–$49.62,
indicating a flat revenue distribution at the top rather than 
a small number of high-value "whale" accounts.
This reduces concentration risk but also suggests limited upside 
from targeting a handful of top spenders, 
a broader loyalty or upsell strategy across the mid-tier 
customer base may yield more impact than VIP-focused retention efforts.
***/

