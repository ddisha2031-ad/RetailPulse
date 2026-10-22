-- RetailPulse | SQLite 3
-- Regional performance and fulfillment-mode analysis.
-- NOTE: The source has no sales-channel field. Ship Mode is a fulfillment
-- segment, not an online/store sales channel.

-- Revenue and orders by region
SELECT
    region,
    ROUND(SUM(sales), 2) AS total_revenue,
    COUNT(DISTINCT order_id) AS total_orders,
    ROUND(SUM(sales) / COUNT(DISTINCT order_id), 2) AS average_order_value,
    SUM(quantity) AS units_sold,
    ROUND(SUM(profit), 2) AS total_profit
FROM v_sales_clean
GROUP BY region
ORDER BY total_revenue DESC;

-- Revenue and orders by state
SELECT
    region,
    state,
    ROUND(SUM(sales), 2) AS total_revenue,
    COUNT(DISTINCT order_id) AS total_orders
FROM v_sales_clean
GROUP BY region, state
ORDER BY total_revenue DESC;

-- Fulfillment / Ship Mode performance
SELECT
    ship_mode,
    ROUND(SUM(sales), 2) AS total_revenue,
    COUNT(DISTINCT order_id) AS total_orders,
    ROUND(SUM(sales) / COUNT(DISTINCT order_id), 2) AS average_order_value,
    ROUND(SUM(profit), 2) AS total_profit
FROM v_sales_clean
GROUP BY ship_mode
ORDER BY total_revenue DESC;

-- Region and fulfillment-mode matrix
SELECT
    region,
    ship_mode,
    ROUND(SUM(sales), 2) AS total_revenue,
    COUNT(DISTINCT order_id) AS total_orders
FROM v_sales_clean
GROUP BY region, ship_mode
ORDER BY region, total_revenue DESC;

-- Monthly revenue by region
SELECT
    year_month,
    region,
    ROUND(SUM(sales), 2) AS revenue
FROM v_sales_clean
GROUP BY year_month, region
ORDER BY year_month, revenue DESC;
