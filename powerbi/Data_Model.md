# Power BI Data Model

## Tables

| Table | Source | Grain | Role |
|---|---|---|---|
| `Sales` | `v_sales_clean` or cleaned CSV | One row per order line | Fact table |
| `Calendar` | Created in Power Query or DAX | One row per date | Date dimension |
| `Product` | Distinct product fields from Sales | One row per product | Dimension table |
| `Geography` | Distinct region/state/city fields | One row per geographic level | Dimension table |

## Recommended star schema

```text
Calendar 1---* Sales *---1 Product
Calendar 1---* Sales *---1 Geography
```

## Calendar table

Create `Calendar` in Power Query using the minimum and maximum `Order Date` values.

Required columns:

- `Date`
- `Year`
- `Month Number`
- `Month Name`
- `Year-Month`
- `Quarter`
- `Year-Quarter`

Mark it as the official date table:

1. Select `Calendar`.
2. Choose **Table tools > Mark as date table**.
3. Select the `Date` column.

## Relationships

| From table | From column | To table | To column | Cardinality | Direction |
|---|---|---|---|---|---|
| `Calendar` | `Date` | `Sales` | `Order Date` | One-to-many | Single |
| `Product` | `Product ID` | `Sales` | `Product ID` | One-to-many | Single |
| `Geography` | `State` | `Sales` | `State` | One-to-many | Single |

Avoid creating unnecessary bidirectional relationships. Use single-direction filtering from dimensions to the `Sales` fact table.

## Field mapping

| Power BI field | Source column |
|---|---|
| Order ID | `order_id` |
| Order Date | `order_date` |
| Ship Mode | `ship_mode` |
| Region | `region` |
| State | `state` |
| Category | `category` |
| Sub-Category | `sub_category` |
| Product Name | `product_name` |
| Sales | `sales` |
| Quantity | `quantity` |
| Discount | `discount` |
| Profit | `profit` |
