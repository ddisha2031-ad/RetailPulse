-- RetailPulse | SQLite 3
-- Data-quality and validation checks.
-- These queries flag issues; they do not delete source records.

-- 1. Row count and date range
SELECT
    COUNT(*) AS total_rows,
    MIN(order_date) AS earliest_order_date,
    MAX(order_date) AS latest_order_date
FROM v_sales_clean;

-- 2. Missing critical values
SELECT
    SUM(CASE WHEN order_id IS NULL OR order_id = '' THEN 1 ELSE 0 END) AS missing_order_id,
    SUM(CASE WHEN order_date IS NULL THEN 1 ELSE 0 END) AS missing_order_date,
    SUM(CASE WHEN region IS NULL OR region = '' THEN 1 ELSE 0 END) AS missing_region,
    SUM(CASE WHEN category IS NULL OR category = '' THEN 1 ELSE 0 END) AS missing_category,
    SUM(CASE WHEN product_name IS NULL OR product_name = '' THEN 1 ELSE 0 END) AS missing_product,
    SUM(CASE WHEN sales IS NULL THEN 1 ELSE 0 END) AS missing_sales,
    SUM(CASE WHEN quantity IS NULL THEN 1 ELSE 0 END) AS missing_quantity
FROM v_sales_clean;

-- 3. Duplicate row IDs
SELECT
    row_id,
    COUNT(*) AS occurrence_count
FROM v_sales_clean
GROUP BY row_id
HAVING COUNT(*) > 1
ORDER BY occurrence_count DESC;

-- 4. Orders with invalid dates
SELECT *
FROM stg_orders
WHERE [Order Date] IS NULL
   OR [Ship Date] IS NULL;

-- 5. Non-positive quantity
SELECT *
FROM v_sales_clean
WHERE quantity <= 0;

-- 6. Negative or null sales
SELECT *
FROM v_sales_clean
WHERE sales < 0 OR sales IS NULL;

-- 7. Discount outside the 0-1 range
SELECT *
FROM v_sales_clean
WHERE discount < 0 OR discount > 1;

-- 8. Ship date earlier than order date
SELECT *
FROM v_sales_clean
WHERE ship_date < order_date;

-- 9. Distinct entity counts
SELECT
    COUNT(DISTINCT order_id) AS distinct_orders,
    COUNT(DISTINCT customer_id) AS distinct_customers,
    COUNT(DISTINCT product_id) AS distinct_products,
    COUNT(DISTINCT region) AS distinct_regions,
    COUNT(DISTINCT category) AS distinct_categories
FROM v_sales_clean;
