# Data Dictionary — Sample Superstore

| Field | Type | Description | Example |
|---|---|---|---|
| Row ID | Integer | Unique identifier for each order line | 1 |
| Order ID | Text | Identifier for a customer order; an order can contain multiple lines | CA-2016-152156 |
| Order Date | Date | Date the order was placed | 2016-11-08 |
| Ship Date | Date | Date the order was shipped | 2016-11-11 |
| Ship Mode | Text | Fulfillment/shipping method | Second Class |
| Customer ID | Text | Unique customer identifier | CG-12520 |
| Customer Name | Text | Customer name | Claire Gute |
| Segment | Text | Customer segment | Consumer |
| Country | Text | Country of the customer | United States |
| City | Text | Customer city | Henderson |
| State | Text | Customer state | Kentucky |
| Postal Code | Text | Customer postal code | 42420 |
| Region | Text | U.S. sales region | South |
| Product ID | Text | Unique product identifier | FUR-BO-10001798 |
| Category | Text | High-level product category | Furniture |
| Sub-Category | Text | Product sub-category | Bookcases |
| Product Name | Text | Product description | Bush Somerset Collection Bookcase |
| Sales | Decimal | Revenue for the order line, as supplied by the source | 261.96 |
| Quantity | Integer | Units sold on the order line | 2 |
| Discount | Decimal | Discount rate applied to the line | 0.00 |
| Profit | Decimal | Profit or loss for the order line | 41.91 |

## Derived fields

| Field | Definition |
|---|---|
| `order_year` | Year extracted from `Order Date` |
| `order_month` | Month number extracted from `Order Date` |
| `year_month` | `YYYY-MM` value used for monthly trends |
