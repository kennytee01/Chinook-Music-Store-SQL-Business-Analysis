-- 1. missing values in key business columns
select count(*) filter (where total is null) as null_totals,
       count(*) filter (where customer_id is null) as null_customer_fk
from invoice;

-- 2. orphaned records (referential integrity check)
select count(*) from invoice i
left join customer c on i.customer_id = c.customer_id
where c.customer_id is null;

-- 3. duplicate invoices (same customer, date, total — shouldn't happen but verify)
select customer_id, invoice_date, total, count(*)
from invoice
group by customer_id, invoice_date, total
having count(*) > 1;

-- 4. negative or zero values that shouldn't exist
select count(*) from invoice where total <= 0;
select count(*) from invoice_line where unit_price <= 0 or quantity <= 0;


-- 5. missing values in track (product-level nulls that could break joins)
select count(*) filter (where album_id is null) as null_album_fk,
       count(*) filter (where genre_id is null) as null_genre_fk,
       count(*) filter (where unit_price is null) as null_price
from track;

-- 6. orphaned tracks (track pointing to a non-existent album)
select count(*) from track t
left join album a on t.album_id = a.album_id
where t.album_id is not null and a.album_id is null;

-- 7. orphaned invoice_line (line item pointing to a non-existent track)
select count(*) from invoice_line il
left join track t on il.track_id = t.track_id
where t.track_id is null;

-- 8. duplicate track names within the same album (possible data entry duplicates)
select album_id, name, count(*)
from track
where album_id is not null
group by album_id, name
having count(*) > 1;
-- there are duplicate but it is completely normal
-- checking the main duplicate
select track_id, album_id, name, composer, milliseconds, unit_price
from track 
    where (album_id, name) in (
    select album_id, name
    from track
    where album_id is not null
    group by album_id, name
    having count(*) > 1 )
order by album_id, name;

-- 9. blank or suspicious artist/album names
select count(*) from artist where name is null or trim(name) = '';
select count(*) from album where title is null or trim(title) = '';


/********************************
Data Quality Audit
Before proceeding with business analysis, a data quality audit was performed on the Chinook database to verify referential integrity and confirm the dataset was analysis-ready.
The audit covered the core relational chain used throughout this analysis: customer, invoice, invoice_line, track, album, artist, and genre. The following checks were carried out:
Missing values: Checked key business fields, including invoice totals, customer foreign keys, album and genre foreign keys on the track table, and unit prices, for null values. No missing values were found in any of these fields.
Referential integrity: Verified that every invoice correctly links to an existing customer, every track correctly links to an existing album, and every invoice_line correctly links to an existing track. No orphaned records were found, confirming all foreign key relationships are intact.
Duplicate records: Checked for duplicate invoices (same customer, invoice date, and total) — none were found. A secondary check for duplicate track titles within the same album identified 6 title pairs (12 rows total) sharing a name within their album — for example, two entries titled "Imagine" under the same album. Full record inspection showed each pair has a distinct track_id and a different duration (milliseconds), confirming these are legitimate distinct recordings sharing a title rather than duplicate data entry errors. No rows were removed.
Invalid values: Checked for negative or zero values in invoice totals, unit prices, and quantities, as these would indicate data entry errors. No invalid values were found.
Blank or incomplete text fields: Checked artist and album name fields for null or blank entries. None were found.
Conclusion: The Chinook database passed all data quality checks with no critical issues identified. One anomaly (repeated track titles within an album) was investigated and confirmed to be legitimate rather than a data error. No cleaning, transformation, or correction of the underlying data was required. The dataset is confirmed clean and ready for business analysis.
***/

