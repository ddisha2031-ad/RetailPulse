# Power BI Dashboard Build Guide

## 1. Connect to data

### Option A — SQLite connection

1. Open Power BI Desktop.
2. Select **Get data > More**.
3. Search for **SQLite database**.
4. Browse to `data/retailpulse.db`.
5. Select the `v_sales_clean` view.
6. Click **Transform Data**.

If the SQLite connector is unavailable, use Option B.

### Option B — CSV import

1. Select **Get data > Text/CSV**.
2. Select `data/sample_superstore.csv`.
3. In Power Query, set `Order Date` and `Ship Date` to Date type.
4. Set `Sales`, `Quantity`, `Discount`, and `Profit` to Decimal Number or Whole Number as appropriate.
5. Rename the query to `Sales`.

## 2. Create the Calendar table

In Power Query:

1. Select **Home > Enter Data** and create a blank query named `Calendar`.
2. Use **Add Column > Custom Column** or an M query to generate dates from the minimum to maximum `Order Date`.
3. Add `Year`, `Month Number`, `Month Name`, `Year-Month`, and `Quarter`.
4. Close and apply.
5. Mark `Calendar` as the date table using its `Date` column.

## 3. Create relationships

Use the Model view:

- `Calendar[Date]` to `Sales[Order Date]`: one-to-many, single direction
- `Product[Product ID]` to `Sales[Product ID]`: one-to-many, single direction
- `Geography[State]` to `Sales[State]`: one-to-many, single direction

## 4. Create measures

Add every measure from `DAX_Measures.md` to a table named `_Measures`.

## 5. Build Page 1 — Executive Overview

| Visual | Fields |
|---|---|
| Card | `Total Revenue` |
| Card | `Total Orders` |
| Card | `Average Order Value` |
| Line chart | `Calendar[Year-Month]`, `Total Revenue` |
| Bar chart | `Sales[Category]`, `Total Revenue` |
| Bar chart | `Sales[Region]`, `Total Revenue` |
| Slicers | `Calendar[Date]`, `Sales[Category]`, `Sales[Region]` |

Recommended layout:

- KPI cards across the top.
- Monthly revenue line chart across the middle.
- Category and region charts side by side below.
- Slicers on the left or in a top filter panel.

## 6. Build Page 2 — Product Performance

| Visual | Fields |
|---|---|
| Bar chart | Top 10 products by `Total Revenue` |
| Bar chart | Bottom 10 products by `Total Revenue` |
| Matrix | `Category`, `Sub-Category`, `Total Revenue`, `Total Profit` |
| Table | Product, revenue, orders, units, profit |
| Drill-through | Product name to a product-detail page |

Create a **Product Detail** drill-through page with:

- Product name
- Category and sub-category
- Revenue, orders, units, profit
- Monthly revenue trend
- Regional revenue breakdown

Enable drill-through by dragging `Sales[Product Name]` into the drill-through field well.

## 7. Build Page 3 — Regional & Fulfillment Analysis

| Visual | Fields |
|---|---|
| Bar chart | `Region`, `Total Revenue` |
| Bar chart | `Region`, `Total Orders` |
| Matrix | `Region`, `Ship Mode`, `Total Revenue`, `Total Orders` |
| Line chart | `Calendar[Year-Month]`, `Total Revenue`, legend `Region` |

Clearly title the Ship Mode section: **Fulfillment Mode Performance**. Do not label it “Sales Channel,” because the source does not contain a sales-channel field.

## 8. Tooltips

Create a report-page tooltip named `Product Tooltip`:

- Product name
- Revenue
- Orders
- Profit
- Monthly revenue sparkline

Enable it on product visuals through **Format > Edit tooltips**.

## 9. Export screenshots

After building the report, export each page as PNG and save it in `screenshots/`:

```text
screenshots/01_executive_overview.png
screenshots/02_product_performance.png
screenshots/03_regional_fulfillment.png
screenshots/04_product_drillthrough.png
```
