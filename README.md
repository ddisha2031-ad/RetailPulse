# RetailPulse — Sales Performance & Revenue Intelligence Dashboard

RetailPulse is an end-to-end retail sales analytics project built with **SQL, Excel, and Power BI**. It analyzes transaction-level sales data to answer business questions about revenue, order volume, average order value, product performance, regional trends, and month-over-month growth.

> **Important:** This repository does not include fabricated business results. Run the pipeline on the downloaded Superstore dataset; all reported figures must come from your own reproducible run.

## Business problem

A retail leadership team needs a single, trustworthy view of sales performance. They need to identify which products, categories, regions, and time periods drive revenue—and which require investigation.

## Business questions

- What are total revenue, total orders, and average order value?
- Which products and categories perform best and worst?
- Which regions generate the most revenue and order volume?
- How does revenue change month over month?
- Which products, regions, or periods need further investigation?

## Dataset

**Dataset:** Tableau Sample Superstore — `Sample - Superstore.xls` / CSV export.  
**Source:** Tableau Public Sample Data: https://public.tableau.com/app/resources/sample-data  
**License / usage:** Tableau provides Superstore as sample data for learning and demonstration. A Kaggle mirror of the dataset is labeled CC0 / Public Domain; verify the license page for the exact copy you download.  
**Recommended download:** Use the official Tableau sample-data page, or a CSV mirror such as: https://github.com/mimansha98/Tableau_Dashboards/blob/master/sample-superstore.csv

The dataset contains transaction-level order lines with:

`Row ID, Order ID, Order Date, Ship Date, Ship Mode, Customer ID, Customer Name, Segment, Country, City, State, Postal Code, Region, Product ID, Category, Sub-Category, Product Name, Sales, Quantity, Discount, Profit`

### Known field limitation

The source dataset does **not** include a true sales channel field such as Online, Store, or Marketplace. Therefore, this project does **not** invent a channel. The Regional & Channel Analysis page uses **Ship Mode** as a fulfillment/shipping segment and clearly labels it as such; it is not presented as a sales channel.

## Technology stack

| Tool | Purpose |
|---|---|
| Excel | Source inspection, data profiling, data dictionary, metric validation, pivot summaries |
| SQL / SQLite | Data loading, validation, cleaning, aggregation, KPIs, trends, rankings |
| Power BI Desktop | Interactive dashboard, data model, DAX measures, drill-through, tooltips |

SQL scripts are written for **SQLite 3** because it is free, portable, and easy to test locally. The logic is broadly transferable to SQL Server, PostgreSQL, or MySQL, but date functions and window-function syntax may require minor changes.

## Metric definitions

| Metric | Definition |
|---|---|
| Revenue / Sales | Sum of the `Sales` field across valid order lines. Sales are treated as the revenue measure supplied by the source; taxes, shipping revenue, returns, and cancellations are not separately identifiable in the Orders sheet. |
| Order count | Count of distinct `Order ID` values. |
| Average order value (AOV) | Total revenue divided by distinct order count. |
| Quantity | Sum of `Quantity` across valid order lines. |
| Discount | Source-provided discount rate; it is already reflected in the supplied `Sales` amount. |
| Profit | Sum of the source `Profit` field. Negative values are retained because they represent genuine unprofitable transactions. |
| MoM revenue growth | `(current month revenue - prior month revenue) / prior month revenue`. |

## Data-cleaning process

1. Download the source file and save it as `data/sample_superstore.csv`.
2. Run `scripts/prepare_data.py` to standardize dates, trim text fields, coerce numeric fields, and create a SQLite database at `data/retailpulse.db`.
3. Run `sql/02_data_quality.sql` to identify missing values, duplicate row IDs, invalid dates, non-positive quantities, and invalid sales amounts.
4. Review results in Excel and document any issues in `excel/retail_data_quality_and_metrics.xlsx`.
5. Use the validated `v_sales_clean` view for all KPI and dashboard calculations.

The cleaning rules are deliberately conservative: rows are flagged rather than silently deleted. A row is excluded from KPI calculations only when it has an invalid date, non-positive quantity, or negative sales amount.

## SQL analysis approach

The `sql/` folder contains numbered, reusable SQLite scripts:

| File | Purpose |
|---|---|
| `01_schema.sql` | Creates tables and the clean analysis view |
| `02_data_quality.sql` | Missing, duplicate, invalid-date, quantity, and sales checks |
| `03_sales_kpis.sql` | Revenue, distinct orders, AOV, quantity, profit |
| `04_product_analysis.sql` | Category, sub-category, and product rankings |
| `05_monthly_trends.sql` | Monthly revenue, orders, AOV, and month-over-month growth |
| `06_regional_channel_analysis.sql` | Region and Ship Mode analysis |

## Power BI dashboard

The Power BI report has three pages:

### Page 1 — Executive Overview
- KPI cards: Total Revenue, Total Orders, Average Order Value
- Monthly revenue trend
- Revenue by category
- Revenue by region
- Slicers: date, category, region

### Page 2 — Product Performance
- Top 10 products by revenue
- Bottom 10 products by revenue
- Category and sub-category comparison
- Product detail drill-through page

### Page 3 — Regional & Fulfillment Analysis
- Revenue and order count by region
- Revenue and order count by Ship Mode
- Regional trend comparison

Because no genuine `.pbix` file can be generated outside Power BI Desktop, this repository provides the complete data model, DAX measures, page layout, and build instructions in `powerbi/`. Do not rename another file to `.pbix`.

## Excel validation workflow

`excel/retail_data_quality_and_metrics.xlsx` contains:

- Data dictionary
- Data-quality checklist
- Metric definitions
- Validation summary tables
- Instructions for building pivot tables

After loading the data, create pivot tables for:

- Total revenue, distinct order count, and AOV
- Revenue by category
- Revenue by region
- Revenue by year-month

Compare these values with `sql/03_sales_kpis.sql`, `sql/04_product_analysis.sql`, and the Power BI card visuals. Investigate any difference before publishing results.

## Setup and execution

### 1. Clone the repository

```bash
git clone https://github.com/<your-username>/RetailPulse.git
cd RetailPulse
```

### 2. Install Python dependencies

```bash
pip install pandas openpyxl
```

### 3. Download the dataset

Download `Sample - Superstore.xls` from Tableau Public Sample Data, or download a CSV version. Save the CSV as:

```text
data/sample_superstore.csv
```

If you downloaded the Excel file, open it and export/save the `Orders` sheet as CSV with the same name.

### 4. Create and load the SQLite database

```bash
python scripts/prepare_data.py
```

This creates `data/retailpulse.db` and loads the cleaned orders data.

### 5. Run SQL analysis

```bash
sqlite3 data/retailpulse.db < sql/01_schema.sql
sqlite3 data/retailpulse.db < sql/02_data_quality.sql
sqlite3 data/retailpulse.db < sql/03_sales_kpis.sql
sqlite3 data/retailpulse.db < sql/04_product_analysis.sql
sqlite3 data/retailpulse.db < sql/05_monthly_trends.sql
sqlite3 data/retailpulse.db < sql/06_regional_channel_analysis.sql
```

### 6. Build the Power BI report

Open Power BI Desktop and follow `powerbi/Dashboard_Design.md`. Connect to `data/retailpulse.db` using the SQLite connector, or import `data/sample_superstore.csv` after running the preparation script.

## Repository structure

```text
RetailPulse/
├── README.md
├── data/
│   ├── README.md
│   ├── sample_data.csv
│   └── sample_superstore.csv   # add after downloading
├── sql/
│   ├── 01_schema.sql
│   ├── 02_data_quality.sql
│   ├── 03_sales_kpis.sql
│   ├── 04_product_analysis.sql
│   ├── 05_monthly_trends.sql
│   └── 06_regional_channel_analysis.sql
├── excel/
│   └── retail_data_quality_and_metrics.xlsx
├── powerbi/
│   ├── DAX_Measures.md
│   ├── Data_Model.md
│   └── Dashboard_Design.md
├── screenshots/
├── scripts/
│   └── prepare_data.py
└── docs/
    ├── data_dictionary.md
    ├── metric_definitions.md
    └── validation_and_insights_template.md
```

## Screenshots

Add exported images here after building the report:

- `screenshots/01_executive_overview.png`
- `screenshots/02_product_performance.png`
- `screenshots/03_regional_fulfillment.png`
- `screenshots/04_product_drillthrough.png`

## Limitations

- The dataset is a fictional Tableau sample dataset, so findings describe the sample business, not a real retailer.
- There is no sales-channel field; Ship Mode is used only as a fulfillment segment.
- The Orders sheet does not distinguish returns or cancellations, so revenue cannot be split into gross sales, returns, and net revenue.
- Product-level rankings can be sensitive to a small number of large orders.
- Month-over-month growth is undefined for the first month with data.

## Future improvements

- Add a returns table if available.
- Add customer retention, repeat-purchase, and basket-analysis measures.
- Add row-level security for regional users.
- Automate scheduled data refresh and data-quality alerts.
- Add profit-margin and discount-impact analysis to the executive page.
