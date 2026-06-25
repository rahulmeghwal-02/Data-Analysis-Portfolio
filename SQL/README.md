# 📊 SQL Data Analytics Portfolio

A collection of SQL projects covering real-world data analysis, data cleaning, and exploratory data analysis (EDA). Built using **Microsoft SQL Server (T-SQL)** with datasets spanning COVID-19 global statistics, Nashville housing records, and video game sales.

---

## 📁 Projects

### 1. 🦠 Covid-19 Data Exploration — `Covid19_PortfolioProject_v1.sql`

**Dataset:** Global COVID-19 deaths and vaccinations data  
**Tool:** SQL Server (T-SQL)

Exploratory analysis of COVID-19 pandemic data using real-world global statistics. Focuses on understanding infection rates, death percentages, and vaccination rollout across countries and continents.

**Key concepts covered:**
- Filtering & ordering with `WHERE`, `ORDER BY`
- Aggregate functions — `SUM()`, `MAX()`, `COUNT()`
- Calculated columns — Death % and Infection % using `CONVERT(DECIMAL)`
- `NULLIF()` to handle division-by-zero safely
- **Window Functions** — `SUM() OVER (PARTITION BY ...)` for rolling vaccination totals
- **JOINs** — Combining `CovidDeaths` and `CovidVaccination` tables
- **CTEs** (`WITH ... AS`) for readable, reusable query logic
- **Temp Tables** (`#PercentVaccinated`) for intermediate storage
- **Views** — Creating `PercentVaccinated` view for Tableau/Power BI dashboards

**Sample analyses:**
- Death percentage in India over time
- Countries with the highest infection rate relative to population
- Continent-wise total death counts
- Global daily case vs. death percentage trend
- Rolling vaccination count per country

---

### 2. 🏠 Nashville Housing — Data Cleaning — `DataCleaning_PortfolioProject_2.sql`

**Dataset:** Nashville, Tennessee housing/property sales records  
**Tool:** SQL Server (T-SQL)

A complete data cleaning pipeline on a messy real estate dataset — one of the most essential and often underrated skills in data analytics.

**Key concepts covered:**
- Date standardization using `CONVERT(DATE, ...)` and `ALTER TABLE ... ADD`
- Filling `NULL` values using self-`JOIN` with `ISNULL()`
- String parsing with `SUBSTRING()` + `CHARINDEX()` to split addresses into Street, City
- Cleaner address splitting using `PARSENAME()` + `REPLACE()` for Owner Address
- Data standardization — converting `'Y'`/`'N'` → `'YES'`/`'NO'` using `CASE WHEN`
- **Duplicate detection & removal** using `ROW_NUMBER() OVER (PARTITION BY ...)` CTE
- Dropping unused columns with `ALTER TABLE ... DROP COLUMN`

**Cleaning steps performed:**
1. Standardized `SaleDate` format
2. Populated missing `PropertyAddress` values using `ParcelID` matching
3. Split `PropertyAddress` into separate Street and City columns
4. Split `OwnerAddress` into Street, City, and State columns
5. Standardized `SoldAsVacant` field values
6. Identified and deleted duplicate rows
7. Removed irrelevant columns

---

### 3. 🎮 Video Games Sales Analysis — `GamesData_Analysis.sql`

**Dataset:** Generated video game sales data (titles, platforms, genres, publishers, regions)  
**Tool:** SQL Server (T-SQL)

> ⚠️ Note: The dataset used is synthetically generated and not real-world data.

Exploratory analysis of a games dataset covering global sales, estimated revenue, platform performance, genre trends, and regional breakdowns.

**Key concepts covered:**
- `COUNT(DISTINCT ...)` for unique title counts
- `SUM()`, `AVG()`, `MAX()` for sales and revenue metrics
- `ROUND()` for cleaner numeric output
- `GROUP BY` with `ORDER BY` for ranked aggregations
- `TOP N` for leaderboard-style queries
- Multi-column `SELECT` for region comparison

**Sample analyses:**
- Total unique game titles in the dataset
- Title count by year and by genre
- Total and highest sales by platform and platform maker
- Global revenue ranking by title and publisher
- Average revenue by genre and platform (Top 10)
- Regional sales breakdown (NA vs EU vs JP) by genre

---

## 🛠️ Tech Stack

| Tool | Purpose |
|------|---------|
| Microsoft SQL Server | Query engine |
| T-SQL | Query language |
| SSMS (SQL Server Management Studio) | IDE |
| Tableau / Power BI *(optional)* | Visualization from Views |

---

## 🧠 Skills Demonstrated

- ✅ Data Exploration & EDA
- ✅ Data Cleaning & Transformation
- ✅ Aggregation & Grouping
- ✅ Joins (INNER, Self-Join)
- ✅ CTEs & Subqueries
- ✅ Window Functions
- ✅ Temp Tables & Views
- ✅ String Manipulation
- ✅ Duplicate Handling

---

## 👤 Author

**Rahul** — BCA Graduate | Aspiring Data Analyst & MCA Student  
Passionate about data, Python, and turning raw data into meaningful insights.

---

> *These projects are part of a growing data analytics portfolio. More projects coming soon.*
