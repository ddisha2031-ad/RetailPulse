-- RetailPulse | SQLite 3
-- Product and category performance.
-- Products are ranked by revenue; profit is included for context.

-- Revenue by category
SELECT
    category,
    ROUND(SUM(sales), 2) AS total_revenue,
    COUNT(DISTINCT order_id) AS total_orders,
    SUM(quantity) AS units_sold,
    ROUND(SUM(profit), 2) AS total_profit
FROM v_sales_clean
GROUP BY category
ORDER BY total_revenue DESC;

-- Revenue by sub-category
SELECT
    category,
    sub_category,
    ROUND(SUM(sales), 2) AS total_revenue,
    COUNT(DISTINCT order_id) AS total_orders,
    ROUND(SUM(profit), 2) AS total_profit
FROM v_sales_clean
GROUP BY category, sub_category
ORDER BY total_revenue DESC;

-- Top 10 products by revenue
WITH product_sales AS (
    SELECT
        product_id,
        product_name,
        category,
        sub_category,
        SUM(sales) AS total_revenue,
        COUNT(DISTINCT order_id) AS total_orders,
        SUM(quantity) AS units_sold,
        SUM(profit) AS total_profit
    FROM v_sales_clean
    GROUP BY product_id, product_name, category, sub_category
)
SELECT
    product_id,
    product_name,
    category,
    sub_category,
    ROUND(total_revenue, 2) AS total_revenue,
    total_orders,
    units_sold,
    ROUND(total_profit, 2) AS total_profit
FROM product_sales
ORDER BY total_revenue DESC
LIMIT 10;

-- Bottom 10 products by revenue
WITH product_sales AS (
    SELECT
        product_id,
        product_name,
        category,
        sub_category,
        SUM(sales) AS total_revenue,
        COUNT(DISTINCT order_id) AS total_orders,
        SUM(quantity) AS units_sold,
        SUM(profit) AS total_profit
    FROM v_sales_clean
    GROUP BY product_id, product_name, category, sub_category
)
SELECT
    product_id,
    product_name,
    category,
    sub_category,
    ROUND(total_revenue, 2) AS total_revenue,
    total_orders,
    units_sold,
    ROUND(total_profit, 2) AS total_profit
FROM product_sales
ORDER BY total_revenue ASC
LIMIT 10;

-- Products with negative profit
SELECT
    product_id,
    product_name,
    category,
    ROUND(SUM(sales), 2) AS total_revenue,
    ROUND(SUM(profit), 2) AS total_profit
FROM v_sales_clean
GROUP BY product_id, product_name, category
HAVING SUM(profit) < 0
ORDER BY total_profit ASC;
