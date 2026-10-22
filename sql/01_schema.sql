-- RetailPulse | SQLite 3
-- Creates the cleaned reporting view used by all analysis queries.
-- The raw table stg_orders is created by scripts/prepare_data.py.

DROP VIEW IF EXISTS v_sales_clean;

CREATE VIEW v_sales_clean AS
SELECT
    CAST([Row ID] AS INTEGER) AS row_id,
    [Order ID] AS order_id,
    [Order Date] AS order_date,
    [Ship Date] AS ship_date,
    [Ship Mode] AS ship_mode,
    [Customer ID] AS customer_id,
    [Segment] AS customer_segment,
    [Country] AS country,
    [City] AS city,
    [State] AS state,
    [Region] AS region,
    [Product ID] AS product_id,
    [Category] AS category,
    [Sub-Category] AS sub_category,
    [Product Name] AS product_name,
    CAST([Sales] AS REAL) AS sales,
    CAST([Quantity] AS INTEGER) AS quantity,
    CAST([Discount] AS REAL) AS discount,
    CAST([Profit] AS REAL) AS profit,
    strftime('%Y', [Order Date]) AS order_year,
    strftime('%m', [Order Date]) AS order_month,
    strftime('%Y-%m', [Order Date]) AS year_month
FROM stg_orders
WHERE [Order Date] IS NOT NULL
  AND CAST([Sales] AS REAL) >= 0
  AND CAST([Quantity] AS INTEGER) > 0;
