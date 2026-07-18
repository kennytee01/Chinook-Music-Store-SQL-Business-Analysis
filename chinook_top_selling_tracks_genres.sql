-- Business Questions
--2. Top-selling tracks/genres
-- The genre level query
select g.name as genre,
       count(il.invoice_line_id) as tracks_sold,
       sum(il.unit_price * il.quantity) as genre_revenue
from invoice_line il
join track t on il.track_id = t.track_id
join genre g on t.genre_id = g.genre_id
group by g.name
order by genre_revenue desc
limit 10;

/******
Insight: Rock is the clear top revenue driver (835 units, $826.65),
nearly 3x the next-closest genre.
However, TV Shows and Drama, despite low unit volume (47 and 29 respectively),
generate disproportionately high revenue per unit 
(~$1.99 vs ~$0.99 for standard tracks), indicating a premium content 
category worth separate consideration in catalog and pricing strategy
rather than being deprioritized based on volume alone.
****/


-- The track-level query
select t.name as track,
       ar.name as artist,
       g.name as genre,
       count(il.invoice_line_id) as times_purchased,
       sum(il.unit_price * il.quantity) as track_revenue
from invoice_line il
join track t on il.track_id = t.track_id
join album al on t.album_id = al.album_id
join artist ar on al.artist_id = ar.artist_id
join genre g on t.genre_id = g.genre_id
group by t.name, ar.name, g.name
order by track_revenue desc
limit 10;

/****
Insight: No single track drives outsized revenue 
— the top 10 are tied at 2–4 purchases each, indicating broad, 
evenly distributed demand across the catalog rather than concentration in a few hits. 
Among actual music tracks, Rock songs ("Eruption," "Sure Know Something") 
lead with the highest purchase frequency (4 each), reinforcing Rock's position as
the top-performing genre identified in the genre-level analysis. 
This suggests marketing/curation efforts are better focused on genre-level trends 
(e.g., Rock, Latin, Metal) rather than chasing individual "hit" tracks,
since no track shows viral-level demand.
*****/
