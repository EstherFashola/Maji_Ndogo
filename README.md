# Maji Ndogo Water Services: SQL Data Exploration, Cleaning & Analysis

## Project Overview

This project uses **MySQL** to explore, clean, and analyse data from the `md_water_services` database.

Across two SQL scripts, I work with employee, location, visit, water-source, water-quality, and well-pollution data to practise a range of SQL techniques and investigate questions relevant to water access and service delivery in Maji Ndogo.

The project follows a practical data workflow:

1. Explore database tables and understand the available records.
2. Investigate data quality issues and prepare data for analysis.
3. Standardise employee contact information.
4. Summarise people, locations, water sources, and field visits.
5. Use aggregate and window functions to compare and rank results.
6. Examine queue patterns across days and hours.

The aim is not simply to retrieve data, but to demonstrate how SQL can turn raw operational records into more organised and useful information.

## Project Objectives

- Explore the structure and contents of the `md_water_services` database.
- Identify distinct water-source types and inspect water-service records.
- Investigate potential inconsistencies in well-pollution records.
- Practise controlled data updates and validation using a working copy.
- Standardise employee email addresses and phone-number formatting.
- Measure employee and location counts.
- Analyse the distribution of water sources and the population served.
- Rank water sources using SQL window functions.
- Calculate the period covered by visit records.
- Examine average queue times and how they vary by day of the week and time of day.

## Project Files

The repository is organised into two SQL stages:

| File | Focus |
|---|---|
| `Maji_Ndogo_part_1.sql` | Initial database exploration, filtering, investigation of well-pollution records, and data-cleaning practice |
| `Maji_Ndogo_Part_2.sql` | Employee data standardisation, summary analysis, water-source analysis, ranking, and queue-time analysis |
| `README.md` | Project overview, methods, skills, and instructions |

Keeping the SQL work in two numbered files preserves the progression of the project while this README presents both parts as one complete portfolio project.

## Database Tables Explored

| Table | Analysis performed |
|---|---|
| `employee` | Generated standardised email addresses, cleaned phone numbers, and counted employees by town |
| `location` | Inspected location records and counted records by town, province, and location type |
| `visits` | Filtered long queue times, examined visit activity, and analysed queue patterns over time |
| `water_source` | Explored water-source types, population served, average people served, and source rankings |
| `water_quality` | Filtered records by subjective quality score and visit count |
| `well_pollution` | Investigated possible inconsistencies between pollution results, descriptions, and biological readings |
| `well_pollution_copy` | Used as a working copy to test data corrections and run validation checks |

## Key Work & SQL Techniques

### 1. Database Exploration and Data Retrieval

I began by selecting the `md_water_services` database and inspecting key tables.

I used:

- `SELECT` to retrieve all records or selected columns.
- `DISTINCT` to identify unique water-source types.
- `WHERE` to filter records based on specified conditions.
- `AND` and `OR` to combine filtering criteria.
- `LIKE` to search for text patterns.

Examples of the questions explored include which visits had queue times above 500 minutes and which water-quality records had a subjective quality score of 10 on the second visit.

### 2. Data Quality Investigation and Cleaning

The first SQL file investigates records in `well_pollution` where a result is recorded as `Clean` even though the biological reading is greater than `0.01`.

It also searches descriptions beginning with `Clean` to identify records that may need review.

The script demonstrates data manipulation with `UPDATE` and creates a copy of the pollution table to test changes and run a validation query.

This part demonstrates an important data practice: investigate a suspected issue, test a correction, and check the result rather than changing records without review.

### 3. Employee Data Standardisation

The second SQL file uses MySQL string functions to prepare employee contact information:

- `REPLACE()` changes the space between an employee's first and last names to a full stop.
- `LOWER()` converts the generated email username to lowercase.
- `CONCAT()` appends the organisation's email domain (`@ndogowater.gov`).
- `TRIM()` removes leading or trailing spaces from phone numbers.
- `LENGTH()` checks the number of characters in phone numbers before and after cleaning.

The script then updates the employee table with the generated email addresses and trimmed phone numbers.

### 4. Aggregation and Grouping

I used aggregate functions to summarise records and support comparisons, including:

- `COUNT()` to count employees, visits, and location records.
- `SUM()` to calculate the total population served by water sources.
- `AVG()` to calculate average people served by source type and average queue times.
- `ROUND()` to present selected calculated values in a more readable format.
- `GROUP BY` to produce summaries by town, province, location type, water-source type, and day.

### 5. Water-Source Analysis and Ranking

The project examines the number of water sources by type, the average number of people served by each source, and the total population served by each source type.

I also used window functions to rank water-source types by the population they serve and to rank individual sources within their source categories.

SQL techniques demonstrated include:

- `RANK() OVER()`
- `DENSE_RANK() OVER()`
- `PARTITION BY`
- `ORDER BY`
- `LIMIT`

These techniques help compare records while retaining row-level detail.

### 6. Visit Dates and Queue-Time Analysis

The visit analysis uses date and time functions to explore service access patterns:

- `MIN()` and `MAX()` identify the earliest and latest visit timestamps.
- `DATEDIFF()` calculates the number of days between those dates.
- `NULLIF()` excludes zero queue-time values from average queue calculations.
- `DAYNAME()` groups queue times by day of the week.
- `HOUR()` and `TIME_FORMAT()` group queue times by hour.
- `CASE` expressions separate queue-time values by day of the week.
- `AVG()` and `ROUND()` calculate and present average queue times.

The final queries arrange average queue-time results by hour, with separate columns for the days of the week. This provides a way to inspect how waiting times vary over the course of a typical week.

## Tools & Technologies

- **MySQL** – Relational database querying and data manipulation.
- **SQL** – Data retrieval, cleaning, transformation, aggregation, and analysis.
- **MySQL Workbench or a compatible MySQL client** – For running and reviewing the SQL scripts.
- **GitHub** – Version control and project portfolio presentation.

## How to Run the Project

1. Set up a MySQL environment, such as MySQL Workbench.
2. Make sure the `md_water_services` database and the tables referenced in the scripts are available.
3. Clone or download this repository.
4. Open and run `Maji_Ndogo_part_1.sql` in your MySQL client.
5. Review the results, then open and run `Maji_Ndogo_Part_2.sql`.
6. Execute data-modification statements carefully and inspect query results as you work through each stage.

> **Prerequisite:** The scripts assume that the `md_water_services` database and its source tables have already been created and populated. These files are analysis scripts, not database setup or data-import scripts.

## Repository Structure

```text
Maji-Ndogo-SQL-Project/
│
├── Maji_Ndogo_part_1.sql
├── Maji_Ndogo_Part_2.sql
└── README.md
