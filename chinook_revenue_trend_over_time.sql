-- Business Questions
--3. Revenue trend over time (monthly/yearly)

select date_part('year', invoice_date) as sales_year,
       date_part('month', invoice_date) as sales_month,
       count(invoice_id) as order_count,
       round(sum(total), 2) as revenue
from invoice
group by sales_year, sales_month
order by sales_year, sales_month;

/*************
Insight: Monthly revenue and order volume remain remarkably stable across
the full 2021–2025 period (~7 orders and ~$37.62 revenue per month),
with only minor deviations in isolated months (e.g., a dip to $23.76
in November 2023, a peak of $52.62 in January 2022). This flat pattern
reflects the synthetic, randomly-generated nature of Chinook's invoice data
rather than a genuine business trend, and should be noted as a dataset limitation.

In a real production dataset, this level of monthly consistency would be highly
unusual and worth investigating for either exceptional business stability
or a data generation artifact — here, it's confirmed to be the latter.

****/

