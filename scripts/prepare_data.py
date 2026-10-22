import pandas as pd
from pathlib import Path
import sqlite3
import sys

ROOT = Path(__file__).resolve().parents[1]
CSV_PATH = ROOT / "data" / "sample_superstore.csv"
DB_PATH = ROOT / "data" / "retailpulse.db"

REQUIRED = [
    "Row ID", "Order ID", "Order Date", "Ship Date", "Ship Mode", "Customer ID",
    "Customer Name", "Segment", "Country", "City", "State", "Postal Code", "Region",
    "Product ID", "Category", "Sub-Category", "Product Name", "Sales", "Quantity",
    "Discount", "Profit"
]

def main():
    if not CSV_PATH.exists():
        sys.exit(
            "Missing data/sample_superstore.csv. Download the Tableau Sample Superstore "
            "dataset and save its Orders sheet as CSV using this exact filename."
        )

    df = pd.read_csv(CSV_PATH)
    missing = [c for c in REQUIRED if c not in df.columns]
    if missing:
        sys.exit(f"Source file is missing required columns: {missing}")

    for col in ["Order ID", "Ship Mode", "Customer ID", "Segment", "Country", "City",
                "State", "Region", "Product ID", "Category", "Sub-Category", "Product Name"]:
        df[col] = df[col].astype(str).str.strip()

    df["Order Date"] = pd.to_datetime(df["Order Date"], errors="coerce")
    df["Ship Date"] = pd.to_datetime(df["Ship Date"], errors="coerce")

    for col in ["Sales", "Quantity", "Discount", "Profit"]:
        df[col] = pd.to_numeric(df[col], errors="coerce")

    df["Order Year"] = df["Order Date"].dt.year
    df["Order Month"] = df["Order Date"].dt.month
    df["YearMonth"] = df["Order Date"].dt.strftime("%Y-%m")

    if DB_PATH.exists():
        DB_PATH.unlink()

    with sqlite3.connect(DB_PATH) as conn:
        df.to_sql("stg_orders", conn, if_exists="replace", index=False)

    print(f"Loaded {len(df):,} rows into {DB_PATH}")

if __name__ == "__main__":
    main()
