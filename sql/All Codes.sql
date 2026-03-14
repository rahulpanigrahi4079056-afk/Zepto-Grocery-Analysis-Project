

drop table groceries.zepto

create table groceries.zepto (
sku_id SERIAL PRIMARY KEY,
category VARCHAR(120),
name VARCHAR(200),
mrp NUMERIC(16,2),
discount_percent NUMERIC(10,2),
available_quantity INTEGER,
discounted_selling_price NUMERIC(10,2),
weight_in_gms NUMERIC(6,2),
out_of_stock BOOLEAN,
quantity INTEGER
);

-- Find null values
select * from groceries.zepto
where name is null
OR
category IS NULL
OR
mrp IS NULL
OR
discount_percent IS NULL
OR
discounted_selling_price IS NULL
OR
weight_in_gms IS NULL
OR
available_quantity IS NULL
OR
out_of_stock IS NULL
OR
quantity IS NULL;

-- 1. DISTINCT CATEGORIES
select distinct category from groceries.zepto order by category

-- 2. IN-STOCK VS OUT-OF-STOCK DISTRIBUTION
select out_of_stock, count(sku_id) from groceries.zepto group by out_of_stock


--3. PRODUCTS WITH MULTIPLE SKUs
select name, count(sku_id) as "Number of Skus" from groceries.zepto group by name having count(sku_id) > 1 order by count(sku_id) desc


--4. DISCOUNT PERCENTAGE SUMMARY STATISTICS
select min(discount_percent) as minimum_discount,
max(discount_percent) as maximum_discount, round(avg(discount_percent),2) as avg_discount 
from groceries.zepto;

-- 5. CATEGORY-WISE PRODUCT COUNT
select category, count(sku_id) as total_products from groceries.zepto
group by category order by total_products desc

-- 6. OUT-OF-STOCK PRODUCTS BY CATEGORY
select category, count(sku_id) as total_stockout from groceries.zepto
where out_of_stock = true group by category order by total_stockout desc

-- 8. TOP 10 MOST DISCOUNTED PRODUCTS
select name, category, mrp, discounted_selling_price, discount_percent from groceries.zepto 
order by discount_percent desc limit 10

select * from groceries.zepto

-- 9. TOP 10 MOST EXPENSIVE PRODUCTS BY MRP
select name, category, mrp
from groceries.zepto
order by mrp desc
limit 10;


----Data Cleaning----

-- 1.DUPLICATE ROW CHECK
select name,
       mrp,
       discounted_selling_price,
       weight_in_gms,
       count(sku_id) as duplicate_count
from groceries.zepto
group by name, mrp, discounted_selling_price, weight_in_gms
having count(sku_id) > 1
order by duplicate_count desc

-- 1a.DELETE DUPLICATE ROWS
delete from groceries.zepto
where sku_id not in (
    select min(sku_id)
    from groceries.zepto
    group by name, mrp, discounted_selling_price, weight_in_gms)

-- 1b. CONFIRM DUPLICATES ARE REMOVED	
select name,
       mrp,
       discounted_selling_price,
       weight_in_gms,
       count(sku_id) as duplicate_count
from groceries.zepto
group by name, mrp, discounted_selling_price, weight_in_gms
having count(sku_id) > 1
order by duplicate_count desc

--2.  DISCOUNT CONSISTENCY CHECK
select name,
       mrp,
       discounted_selling_price,
       discount_percent as stated_discount,
       floor((mrp - discounted_selling_price) * 100.0 / mrp) as calculated_discount,
       floor((mrp - discounted_selling_price) * 100.0 / mrp) - discount_percent as delta
from groceries.zepto
where mrp > 0
and discount_percent != floor((mrp - discounted_selling_price) * 100.0 / mrp)
order by delta desc

--3.IDENTIFY ZERO WEIGHT ROWS
select *
from groceries.zepto
where weight_in_gms = 0

--3a. FLAG ZERO WEIGHT ROWS
alter table groceries.zepto
add column weight_flag boolean default false;

update groceries.zepto
set weight_flag = true
where weight_in_gms = 0

--4. PRICE INTEGRITY CHECK
select *
from groceries.zepto
where discounted_selling_price > mrp

--5. Identify Zero mrp rows
select *
from groceries.zepto
where mrp = 0;

--5a. Delete zero mrp rows
delete from groceries.zepto
where mrp = 0;


--- final cleaned sheet
select *
from groceries.zepto
order by category, name


-- Data analysis---

-- 1. CATEGORY-WISE AVERAGE MRP
select category,
       round(avg(mrp), 2) as avg_mrp
from groceries.zepto
group by category
order by avg_mrp desc

--2. CATEGORY-WISE AVERAGE DISCOUNT
select category,
       round(avg(discount_percent), 2) as avg_discount
from groceries.zepto
group by category
order by avg_discount desc

-- 3. DISCOUNT DISTRIBUTION — BUCKET ANALYSIS
select
    case
        when discount_percent = 0 then '0% — No Discount'
        when discount_percent < 10 then '1-9% — Low Discount'
        when discount_percent between 10 and 20 then '10-20% — Moderate Discount'
        when discount_percent > 20 then '>20% — High Discount'
    end as discount_bucket,
    count(sku_id) as total_products
from groceries.zepto
group by discount_bucket
order by total_products desc

-- 4. REVENUE POTENTIAL PER CATEGORY — AT MRP
select category,
       sum(mrp * available_quantity) as revenue_at_mrp
from groceries.zepto
where out_of_stock = false
group by category
order by revenue_at_mrp desc

-- 5. REVENUE POTENTIAL PER CATEGORY — AT DISCOUNTED PRICE
select category,
       sum(discounted_selling_price * available_quantity) as revenue_at_discounted_price
from groceries.zepto
where out_of_stock = false
group by category
order by revenue_at_discounted_price desc

-- 6. REVENUE LOSS DUE TO DISCOUNTS PER CATEGORY
select category,
       sum(mrp * available_quantity) as revenue_at_mrp,
       sum(discounted_selling_price * available_quantity) as revenue_at_discounted_price,
       sum((mrp - discounted_selling_price) * available_quantity) as revenue_loss
from groceries.zepto
where out_of_stock = false
group by category
order by revenue_loss desc

-- 7. BEST VALUE PRODUCTS — PRICE PER GRAM
select name,
       category,
       discounted_selling_price,
       weight_in_gms,
       round(discounted_selling_price / nullif(weight_in_gms, 0), 2) as price_per_gram
from groceries.zepto
where out_of_stock = false
and weight_flag = false
order by price_per_gram asc
limit 10 

-- 8. MOST EXPENSIVE PRODUCTS — PRICE PER GRAM
select name,
       category,
       discounted_selling_price,
       weight_in_gms,
       round(discounted_selling_price / nullif(weight_in_gms, 0), 2) as price_per_gram
from groceries.zepto
where out_of_stock = false
and weight_flag = false
order by price_per_gram desc
limit 10

-- 9. STOCK DEPTH BY CATEGORY
select category,
       round(avg(available_quantity), 2) as avg_stock_depth,
       sum(available_quantity) as total_stock
from groceries.zepto
where out_of_stock = false
group by category
order by avg_stock_depth desc


-- 10. BEST DISCOUNTED IN-STOCK PRODUCTS
select name,
       category,
       mrp,
       discounted_selling_price,
       discount_percent as discount_percent
from groceries.zepto
where out_of_stock = false
order by discount_percent desc
limit 10
