# 🧹 Nashville Housing Data Cleaning | SQL Server

A hands-on SQL Server data cleaning project focused on transforming raw Nashville Housing data into a more consistent, structured, and analysis-ready dataset.

This project demonstrates practical SQL data preparation techniques, including date standardization, missing-value handling, string manipulation, data normalization, duplicate detection, and schema modification.

---

## 🎯 Project Objectives

The main objective was to improve data quality and prepare the Nashville Housing dataset for further analysis and reporting.

The project covers eight data-cleaning stages:

| # | Objective | SQL Techniques |
|---|---|---|
| 1 | Explore the dataset | `SELECT`, `TOP`, `TABLESAMPLE` |
| 2 | Standardize SaleDate | `CONVERT()`, `UPDATE` |
| 3 | Populate missing PropertyAddress values | Self JOIN, `ISNULL()` |
| 4 | Split PropertyAddress into Address and City | `SUBSTRING()`, `CHARINDEX()`, `TRIM()` |
| 5 | Split OwnerAddress into Address, City and State | `PARSENAME()`, `REPLACE()`, `TRIM()` |
| 6 | Standardize SoldAsVacant values | `CASE WHEN`, `UPDATE` |
| 7 | Identify and remove duplicate records | CTE, `ROW_NUMBER()`, `PARTITION BY` |
| 8 | Remove unused columns | `ALTER TABLE`, `DROP COLUMN` |

---

## 🛠️ Tools & Technologies

- **Database:** Microsoft SQL Server
- **SQL Environment:** Visual Studio Code + DBCode Extension
- **Database Management:** SQL Server Management Studio (SSMS)
- **Language:** T-SQL

---

## 🔍 Data Cleaning Process

### 1. Dataset Exploration
Inspected the original Nashville Housing dataset to understand its structure, columns, and data.

### 2. SaleDate Standardization
Converted the SaleDate column into the SQL Server `DATE` data type to eliminate unnecessary time information and standardize date representation.

### 3. Handling Missing Property Addresses
Used a self JOIN on `ParcelID` to identify records sharing the same property identifier and retrieve available PropertyAddress values for records with missing addresses.

### 4. PropertyAddress Transformation
Separated PropertyAddress into two individual columns:
- PropertySplitAddress
- PropertySplitCity

Used string functions to extract the address and city based on the comma delimiter.

### 5. OwnerAddress Transformation
Separated OwnerAddress into three individual columns:
- OwnerSplitAddress
- OwnerSplitCity
- OwnerSplitState

Applied `PARSENAME()` and `REPLACE()` to extract the individual components.

### 6. Standardizing Categorical Values
Standardized the SoldAsVacant column by replacing:
- `Y` → `Yes`
- `N` → `No`

Used a `CASE WHEN` expression to preserve other existing values.

### 7. Duplicate Removal
Identified duplicate records using a Common Table Expression (CTE) and the `ROW_NUMBER()` window function.

Duplicate identification was based on:
- ParcelID
- PropertyAddress
- SalePrice
- SaleDate
- LegalReference

Retained the record with the lowest UniqueID and removed subsequent duplicates.

### 8. Removing Unused Columns
Removed columns considered unnecessary for the intended analytical dataset using `ALTER TABLE ... DROP COLUMN`.

Columns removed:
- OwnerAddress
- TaxDistrict
- PropertyAddress
- SaleDate

---

## 💡 SQL Concepts Practiced

This project provided practical experience with:

- Data exploration and inspection
- Data type conversion
- NULL handling
- Self JOIN operations
- String manipulation
- Conditional transformations
- Common Table Expressions (CTEs)
- Window functions
- Duplicate detection and removal
- Database schema modification
- Data quality validation

---

## 📂 Repository Structure

```text
Nashville-Housing-SQL-Data-Cleaning/
│
├── README.md
│
├── SQL/
│   └── NashvilleHousing_DataCleaning.sql
│
└── Dataset/
    └── NashvilleHousing.csv
```

*The folder structure above represents the recommended repository organization.*

---

## 🚀 How to Run This Project

1. Install Microsoft SQL Server.
2. Open SQL Server Management Studio or connect through VS Code using the DBCode extension.
3. Create a database for the project.
4. Import the Nashville Housing dataset.
5. Ensure the table is named `dbo.NashvilleHousing`.
6. Open the SQL script.
7. Execute the cleaning operations in sequence.
8. Inspect the resulting dataset and validate the transformations.

**Important:** Run this project against a backup or working copy. Duplicate deletion and column removal permanently modify the table.

---

## 📈 Project Outcome

The project transforms the original Nashville Housing dataset through a series of SQL-based cleaning operations.

The resulting dataset features:

- Standardized date values.
- Populated property addresses where matching records provide reliable information.
- Separated property and owner address components.
- Standardized categorical values.
- Reduced duplicate records.
- Removal of selected unnecessary columns.

The cleaned dataset is better structured for subsequent exploratory data analysis and business intelligence workflows.

---

## 👨‍💻 Author

**Achraf**

Aspiring Data Analyst | SQL | Power BI | Excel | Python

This project is part of my data analytics portfolio, demonstrating practical SQL Server skills and my ability to prepare raw datasets for analytical use.

---

*Learning by doing. Cleaning data. Building analytical skills, one query at a time.*