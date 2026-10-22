-- RetailPulse | SQLite 3
-- Core sales KPIs.
-- Revenue = SUM(Sales). Order count = COUNT(DISTINCT order_id).

SELECT
    ROUND(SUM(sales), 2) AS total_revenue,
    COUNT(DISTINCT order_id) AS total_orders,
    ROUND(SUM(sales) / COUNT(DISTINCT order_id), 2) AS average_order_value,
    SUM(quantity) AS total_units_sold,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND(SUM(profit) / SUM(sales) * 100, 2) AS profit_margin_pct
FROM v_sales_clean;

-- Revenue, orders, AOV, and profit by year
SELECT
    order_year,
    ROUND(SUM(sales), 2) AS total_revenue,
    COUNT(DISTINCT order_id) AS total_orders,
    ROUND(SUM(sales) / COUNT(DISTINCT order_id), 2) AS average_order_value,
    ROUND(SUM(profit), 2) AS total_profit
FROM v_sales_clean
GROUP BY order_year
ORDER BY order_year;
