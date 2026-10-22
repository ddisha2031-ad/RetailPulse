-- RetailPulse | SQLite 3
-- Monthly revenue, orders, AOV, and month-over-month revenue growth.

WITH monthly_sales AS (
    SELECT
        year_month,
        SUM(sales) AS revenue,
        COUNT(DISTINCT order_id) AS orders,
        SUM(sales) / COUNT(DISTINCT order_id) AS average_order_value
    FROM v_sales_clean
    GROUP BY year_month
)
SELECT
    year_month,
    ROUND(revenue, 2) AS revenue,
    orders,
    ROUND(average_order_value, 2) AS average_order_value,
    ROUND(
        LAG(revenue) OVER (ORDER BY year_month), 2
    ) AS prior_month_revenue,
    ROUND(
        (revenue - LAG(revenue) OVER (ORDER BY year_month))
        / LAG(revenue) OVER (ORDER BY year_month) * 100,
        2
    ) AS mom_revenue_growth_pct
FROM monthly_sales
ORDER BY year_month;

-- Quarterly revenue trend
SELECT
    substr(year_month, 1, 4) AS order_year,
    CASE
        WHEN CAST(substr(year_month, 6, 2) AS INTEGER) BETWEEN 1 AND 3 THEN 'Q1'
        WHEN CAST(substr(year_month, 6, 2) AS INTEGER) BETWEEN 4 AND 6 THEN 'Q2'
        WHEN CAST(substr(year_month, 6, 2) AS INTEGER) BETWEEN 7 AND 9 THEN 'Q3'
        ELSE 'Q4'
    END AS quarter,
    ROUND(SUM(sales), 2) AS revenue,
    COUNT(DISTINCT order_id) AS orders
FROM v_sales_clean
GROUP BY order_year, quarter
ORDER BY order_year, quarter;
