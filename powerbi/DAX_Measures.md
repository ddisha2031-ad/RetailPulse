# Power BI DAX Measures

Create these as measures in a dedicated measure table named `_Measures`.

## Core KPIs

```dax
Total Revenue = SUM(Sales[Sales])
```

```dax
Total Orders = DISTINCTCOUNT(Sales[Order ID])
```

```dax
Average Order Value =
DIVIDE([Total Revenue], [Total Orders])
```

```dax
Total Units Sold = SUM(Sales[Quantity])
```

```dax
Total Profit = SUM(Sales[Profit])
```

```dax
Profit Margin % =
DIVIDE([Total Profit], [Total Revenue])
```

## Time intelligence

```dax
Revenue PY =
CALCULATE(
    [Total Revenue],
    DATEADD('Calendar'[Date], -1, YEAR)
)
```

```dax
Revenue YoY % =
DIVIDE(
    [Total Revenue] - [Revenue PY],
    [Revenue PY]
)
```

```dax
Revenue MoM =
CALCULATE(
    [Total Revenue],
    DATEADD('Calendar'[Date], -1, MONTH)
)
```

```dax
Revenue MoM % =
DIVIDE(
    [Total Revenue] - [Revenue MoM],
    [Revenue MoM]
)
```

## Product rankings

```dax
Product Revenue Rank =
RANKX(
    ALLSELECTED(Sales[Product Name]),
    [Total Revenue],
    ,
    DESC,
    DENSE
)
```

```dax
Top 10 Product Revenue =
CALCULATE(
    [Total Revenue],
    TOPN(
        10,
        ALLSELECTED(Sales[Product Name]),
        [Total Revenue],
        DESC
    )
)
```

```dax
Bottom 10 Product Revenue =
CALCULATE(
    [Total Revenue],
    TOPN(
        10,
        ALLSELECTED(Sales[Product Name]),
        [Total Revenue],
        ASC
    )
)
```

## Formatting guidance

- Currency: one decimal place or whole numbers, depending on report width.
- Percentages: one decimal place.
- Use a consistent color scheme: one accent color for positive performance and a neutral gray/red for negative values.
