# Data folder

## Required source file

Place the downloaded Superstore CSV here:

```text
data/sample_superstore.csv
```

Expected columns:

```text
Row ID, Order ID, Order Date, Ship Date, Ship Mode, Customer ID, Customer Name,
Segment, Country, City, State, Postal Code, Region, Product ID, Category,
Sub-Category, Product Name, Sales, Quantity, Discount, Profit
```

## Download options

1. Official Tableau sample-data page: https://public.tableau.com/app/resources/sample-data
2. CSV mirror: https://github.com/mimansha98/Tableau_Dashboards/blob/master/sample-superstore.csv

## Sample file

`sample_data.csv` is a tiny, clearly synthetic smoke-test file used only to verify that the SQL scripts and data-preparation code execute correctly. It must not be used for business insights or portfolio screenshots.

## Database

After running `python scripts/prepare_data.py`, SQLite creates:

```text
data/retailpulse.db
```
