# Validation and Insights Template

Complete this file only after running the SQL scripts and building the Power BI report. Do not enter estimated or invented values.

## 1. Validation checklist

| Check | SQL result | Excel result | Power BI result | Match? | Action |
|---|---:|---:|---:|---|---|
| Total revenue |  |  |  |  |  |
| Total distinct orders |  |  |  |  |  |
| Average order value |  |  |  |  |  |
| Revenue by category |  |  |  |  |  |
| Revenue by region |  |  |  |  |  |
| Monthly revenue trend |  |  |  |  |  |
| Top product by revenue |  |  |  |  |  |

## 2. Data-quality findings

Record only issues actually observed in your downloaded dataset:

- Missing values:
- Duplicate row IDs:
- Invalid dates:
- Non-positive quantities:
- Negative sales values:
- Discounts outside 0-100%:
- Ship dates before order dates:

## 3. Business insights

Use this structure for each insight:

**Finding:** State the measured result.  
**Evidence:** Name the SQL query, Excel pivot, or Power BI visual.  
**Recommendation:** Explain a practical next step.  
**Limitation:** State what the data cannot prove.

Example format:

```text
Finding: [Category] generated the highest revenue in the analysis period.
Evidence: sql/04_product_analysis.sql, Revenue by category query.
Recommendation: Review inventory, pricing, and promotional support for this category.
Limitation: Revenue alone does not establish customer preference or future demand.
```

## 4. Recommendations

Only include recommendations supported by calculated results.

- Product action:
- Category action:
- Regional action:
- Fulfillment action:
- Data action:

## 5. Limitations

- The dataset is fictional sample data.
- No sales-channel field exists.
- Returns and cancellations are not separately identified.
- Correlation between metrics does not prove causation.
