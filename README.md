# 🛒 Zepto Grocery — Business-Analytics Project

![PostgreSQL](https://img.shields.io/badge/PostgreSQL-316192?style=for-the-badge&logo=postgresql&logoColor=white)
![Power BI](https://img.shields.io/badge/PowerBI-F2C811?style=for-the-badge&logo=powerbi&logoColor=black)
![Business Analytics](https://img.shields.io/badge/Business%20Analytics-0078D6?style=for-the-badge&logoColor=white)
![Status](https://img.shields.io/badge/Status-Completed-brightgreen?style=for-the-badge)

---

## 📌 Project Overview

An end-to-end Business-Analytics project on Zepto's grocery product catalog.
Zepto is an Indian quick commerce platform delivering groceries in 10 minutes,
competing with Blinkit and Swiggy Instamart across Indian metro cities.

This project covers the complete Business Analyst workflow —
from raw data to actionable business recommendations.

---

## 🎯 Objective

- Understand Zepto's product catalog structure
- Analyse pricing patterns and discount strategy
- Identify stock availability issues
- Calculate revenue potential and revenue loss
- Provide actionable business recommendations

---

## 🛠 Tools Used

| Tool | Purpose |
|---|---|
| PostgreSQL | Data storage, cleaning and analysis |
| pgAdmin 4 | Database management |
| Power BI Desktop | Data visualization and dashboard |
| GitHub | Version control and project showcase |

---

## 📂 Dataset

| Detail | Value |
|---|---|
| Source | Zepto grocery catalog snapshot |
| Raw Records | 3,732 SKUs |
| Cleaned Records | 1,794 SKUs |
| Columns | 12 (10 original + 2 engineered) |
| Categories | 9 |

---

## 🔄 Project Workflow
```
Raw CSV → PostgreSQL → Exploration → Cleaning → Analysis → Insights → Power BI Dashboard
```

---

## 📁 Repository Structure
```
Zepto-Grocery-Analysis-Project/
│
├── README.md
│
├── dataset/
│   └── zepto_v2.csv
│
├── sql/
│   ├── 1_table_setup.sql
│   ├── 2_data_exploration.sql
│   ├── 3_data_cleaning.sql
│   └── 4_data_analysis.sql
│
├── insights/
│   └── insights_and_recommendations.docx
│
└── visuals/
    ├── Zepto_Grocery_Dashboard.pbix
    └── Zepto_Grocery_Dashboard.pdf
```

---

## 🔍 Section 1 — Data Exploration

Key questions answered:
- How many SKUs exist in the catalog?
- What categories are available?
- What is the price and discount range?
- Which products have multiple SKUs?
- How many products are out of stock?

---

## 🧹 Section 2 — Data Cleaning

| Issue Found | Action Taken |
|---|---|
| 1 row with MRP = 0 | Deleted |
| 4 rows with weight = 0 | Flagged with weight_flag column |
| Duplicate rows | Detected and deleted |
| Discount % rounding mismatch | Added discount_percent_corrected column |
| Price integrity check | Confirmed clean — no violations |

---

## 📊 Section 3 — Data Analysis

| # | Analysis | Key Finding |
|---|---|---|
| 1 | Category wise avg MRP | Meats & Fish highest at ₹244 avg |
| 2 | Category wise avg discount | Fruits & Veg highest at 15.5% |
| 3 | Discount bucket distribution | 33.89% products in 1-9% low discount |
| 4 | Revenue at MRP by category | Cooking Essentials highest potential |
| 5 | Revenue at discounted price | Significant gap from MRP |
| 6 | Revenue loss by category | Cooking Essentials loses ₹4.12L |
| 7 | Best value products price/gram | Vicks Cough Drops ₹1.72/gram |
| 8 | Most expensive price/gram | Nivea Lip Balm ₹3,380/gram |
| 9 | Stock depth by category | Meats & Fish critically low at 1.76 |
| 10 | Best discounted in-stock products | Dukes Waffy 51% off |

---

## 📈 Section 4 — Power BI Dashboard

6 charts built in Power BI Desktop:

| Chart | Type | Insight |
|---|---|---|
| Product Count by Category | Bar Chart | Cooking Essentials dominates |
| Avg Discount by Category | Bar Chart | Fruits & Veg most discounted |
| Discount Bucket Distribution | Pie Chart | 29% products have zero discount |
| Revenue Loss by Category | Bar Chart | Cooking Essentials ₹4.0M loss |
| Out of Stock by Category | Bar Chart | Cooking Essentials 64 SKUs |
| Stock Depth by Category | Bar Chart | Meats & Fish 1.76 avg depth |

---

## 💡 Key Insights

1. **Cooking Essentials** is the most problematic category —
   64 SKUs out of stock AND ₹4.12L revenue loss from discounts

2. **Fruits & Vegetables** has the highest discount at 15.5%
   despite being the lowest priced category —
   likely a loss-leader strategy to drive daily app opens

3. **29% of products carry zero discount** —
   missed conversion opportunity across the catalog

4. **Meats, Fish & Eggs** stock depth of 1.76 units per SKU
   is critically low for a premium perishable category

5. **Personal Care** is correctly protected from heavy discounting —
   customers buy on brand trust, not price

---

## ✅ Recommendations

### 🔴 Immediate
- Restock Cooking Essentials — 64 SKUs out of stock
- Review 50% discounts on Ceres Foods and Chef's Basket
- Replenish Meats, Fish & Eggs stock urgently

### 🟠 Short Term
- Activate promotions for 534 zero-discount products
- Promote high value-per-gram products on homepage
- Reduce unnecessary discounts on Home & Cleaning

### 🟢 Strategic
- Build category-specific discount rules
- Set minimum stock threshold alerts per category
- Benchmark discount strategy vs Blinkit and Swiggy Instamart

---

## 📊 Summary Metrics

| Metric | Value |
|---|---|
| Total SKUs | 1,794 |
| Total Categories | 9 |
| Avg Discount | ~7.6% |
| Max Discount | 51% |
| Zero Discount Products | 534 (29%) |
| Total Out of Stock SKUs | 217 |
| Highest Revenue Loss Category | Cooking Essentials — ₹4.12L |
| Best Value Product | Vicks Cough Drops — ₹1.72/gram |
| Lowest Stock Category | Meats, Fish & Eggs — 1.76 avg |

---

## 👤 Author

**Rahul Panigrahi**

---

*This project was built entirely using PostgreSQL for data work
and Power BI Desktop for visualization.*
```
