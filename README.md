# Chinook-Music-Store-SQL-Business-Analysis
A SQL-based analysis of the Chinook digital music store database, covering data quality auditing, top customers, genre/track performance, revenue trends, and purchasing behavior — all built in PostgreSQL.

# Chinook Music Store — SQL Business Analysis

**Analyzed by:** Timothy Kehinde, Data Analyst

A SQL-based analysis of the Chinook digital music store database, covering
data quality auditing, top customers, genre/track performance, revenue
trends, and purchasing behavior — all built in PostgreSQL.

# Business Problem
1. Who are the top spending customer
2. What is the  top sellinig tracks/genres
3. what is the revenue over time
4. what are the purchasing behaviour of the customer, like average order value, order per customer, or purchases by country

Each Business problem have a subsequent corresponding additional solve problem under them to mame the analysis more deeper and understanding for the business

## Why I started with an audit, not the analysis
After understanding the business question and pronlems, now to Data Auditing?
Data understanding helps to get familliar to the existing data that i have and have full understanding about the data completely.

Before touching any business question, I ran a full data quality check on
the database — missing values, broken relationships between tables,
duplicate records, invalid entries.
The logic is simple: if you don't know
whether the data is trustworthy, you don't know whether your insights are
either. I'd rather spend an hour confirming the data is clean than present a
number that turns out to be wrong.

The database passed every check. No missing values in the fields that
matter (invoice totals, customer links, album/genre links, unit prices), no
broken foreign key relationships, no duplicate invoices. One thing did come
up during the duplicate check — a handful of tracks shared the same title
within the same album (for example, two tracks both called "Imagine" under
one album). I pulled the actual rows and checked them individually rather
than assuming it was an error: each pair had a different track ID and a
different length, so these are legitimate separate recordings that happen
to share a name, not duplicate data entry. Nothing was removed.

Full detail is in `Data_Quality_Summary.txt`.


## What I found

**Top customers.** The top 10 customers by spend sit in a narrow band,
between $42.62 and $49.62. That's worth noting because it tells a different
story than most "top customer" analyses — there's no small group of whale
accounts carrying the business. Revenue at the top is spread fairly evenly,
which cuts concentration risk but also means there isn't much extra upside
in chasing a handful of VIPs. A broader loyalty or upsell push across the
mid-tier customer base is more likely to move the needle than a VIP-focused
retention plan.
| `chinook_top_spending_customers.sql` | Top customer analysis |


**Genres.** Rock is the clear leader — 835 units sold, $826.65 in revenue,
close to three times the next genre. But the more interesting finding is
in the numbers most people would skip past: TV Shows and Drama sell in much
smaller volume (47 and 29 units) yet earn close to double the revenue per
unit of a standard track (~$1.99 vs ~$0.99). Volume alone would tell you to
deprioritize these categories. Revenue-per-unit says the opposite — they're
a premium category worth keeping in the pricing and catalog conversation on
their own terms, not judged purely on unit count.
| `chinook_top_selling_tracks_genres.sql` | Genre and track performance |

At the track level, no single song is driving outsized revenue — the top 10
tracks are all tied at 2-4 purchases each. Demand is spread across the
catalog rather than concentrated in a few hits, and the strongest individual
tracks ("Eruption," "Sure Know Something") are Rock, which lines up with
Rock's lead at the genre level. The practical takeaway: marketing and
curation decisions are better made at the genre level than by chasing
individual "hit" tracks, since nothing here shows viral-level demand.

**Revenue over time.** Monthly revenue holds remarkably steady across the
full 2021-2025 window — roughly 7 orders and $37.62 in revenue per month,
with only small deviations (a dip to $23.76 in November 2023, a peak of
$52.62 in January 2022). I want to be upfront about what this means rather
than oversell it: this level of month-to-month consistency isn't something
you'd expect from a real, growing business — it reads as a sign that
Chinook's invoice data is synthetic/demo data rather than organic sales
activity. In a live business, I'd flag this pattern as worth investigating.
Here, I'm flagging it as a known limitation of the dataset instead of
dressing it up as a "stable business" story the data doesn't actually
support.
| `chinook_revenue_trend_over_time.sql` | Monthly/yearly revenue trend |

**Purchasing behavior.** Every customer in the dataset places exactly 7
orders. That one detail changes how you should read the "top spenders"
list — if order count never varies, then who ranks highest is driven
entirely by average order value, not by how often someone buys. Combined
with the flat monthly revenue pattern above, this points the same
direction: order volume looks simulated rather than organic. In a real
dataset, seeing this would normally lead to an "increase orders per
customer" recommendation. Here, that recommendation wouldn't hold up — the
data can only really support average order value as a lever for
differentiating customer value, so that's what I said, rather than forcing
a conclusion the numbers don't back.
| `chinook_purchasing__behavior.sql` | Order frequency, avg order value, revenue by country |

One more thing worth flagging on country-level revenue: the USA generates
the highest total revenue ($523.06), but that's simply because it has the
most customers (13), not because those customers spend more individually.
On a per-customer basis, Czech Republic ($45.12) and Chile ($46.62) actually
outperform the USA ($40.24) — though with only 1-2 customers behind each of
those countries, that's a direction to watch, not a solid trend to act on
yet. I called this out specifically because it would be easy to
misread as "expand into Czech Republic" when the sample size doesn't
support that yet.

## What's in this repo

| File | What it covers |
|---|---|
| `chinook_Data_Cleaning.sql` | Full data quality audit query set |
| `Data_Quality_Summary.txt` | Written summary of audit findings |
| `chinook_top_spending_customers.sql` | Top customer analysis |
| `chinook_top_selling_tracks_genres.sql` | Genre and track performance |
| `chinook_revenue_trend_over_time.sql` | Monthly/yearly revenue trend |
| `chinook_purchasing__behavior.sql` | Order frequency, avg order value, revenue by country |
| `Chinook_PostgreSql.sql` | Database schema and setup |
| `ERD_Relationships.pgerd` | Entity relationship diagram |

## Tools

PostgreSQL, pgAdmin — joins, CTEs, window functions, aggregates.

---

**Find the full documentation in `Data_Quality_Summary.txt` and the
individual `.sql` files above** — each query has its finding written
directly underneath it. 

---

**Timothy Kehinde**
Data Analyst
