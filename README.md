# LANDING-PAGE-PERFORMANCE
Landing page performance analysis using SQL, Excel, and Power BI to identify conversion drivers, bounce rate issues, and revenue optimization opportunities.
# Data Analytics Portfolio

Ike Emeka Ernest  
Aspiring Data Analyst | Excel • SQL • Power BI • Python (Learning)

---

## About Me
I am an aspiring Data Analyst focused on transforming raw data into actionable business insights that improve revenue, user experience, and decision-making.

Core Skills:
- Excel (Data inspection, validation, exploratory analysis)
- SQL (Data cleaning, joins, CTEs, Window Functions, transformation)
- Power BI (Dashboards, Funnel & Cohort Analysis)
- Business Analytics (Conversion Optimization, ROI Analysis)
- Python (Currently Learning)

---

# Project 1: Landing Page Performance Analysis

## Business Problem
An e-commerce platform experienced inconsistent performance across multiple landing pages, resulting in high bounce rates and lost revenue opportunities.

---

## Tools Used
- SQL (Data cleaning, transformation, joins, and aggregation)
- Excel (Data inspection and validation across multiple joined tables)
- Power BI (Dashboard and visualization)

---

## Key Metrics

**Traffic & Engagement**
- Total Visits: **473,000**
- Bounce Rate: **44.76%**

**Performance**
- Conversion Rate: **6.83%**
- Orders: **32,310**

**Revenue**
- Total Revenue: **$2.63M**

---

## SQL Data Pipeline Design

This project uses a structured SQL workflow split into two distinct layers to support both statistical analysis and business intelligence reporting.

---

### 1. Data Preparation Layer (ETL for Excel Analysis)

SQL was used to prepare and transform raw data before exporting to Excel for statistical analysis.

Key operations included:
- Data cleaning (removing duplicates, handling missing values)
- Joining multiple raw tables into a unified analytical dataset
- Creating calculated fields for statistical testing
- Aggregating data for hypothesis testing inputs

This dataset was exported to Excel for:
- Chi-Square tests
- Hypothesis testing
- Statistical validation of landing page performance

---

### 2. BI Reporting Layer (Power BI + DAX)

A separate SQL dataset was created specifically for Power BI reporting and dashboard development.

This layer focused on:
- Aggregated KPI tables for fast dashboard performance
- Conversion rate calculations
- Bounce rate and engagement metrics
- Data modeling for star-schema-style reporting

DAX measures were then used in Power BI to:
- Calculate dynamic conversion rates
- Measure bounce rate performance
- Compare landing page effectiveness
- Build interactive visualizations for business decision-making

---

### Sample SQL Query (Reporting Layer)

```sql
view_number as (select 
h.website_session_id,
btrim(regexp_replace(h.pageview_url,'[^a-zA-Z0-9]',' ','g')) as landing_page,
count(wp.*) as viewed
from homepage as h
inner join website_pageviews  as wp
on h.website_session_id=wp.website_session_id
group by 1,2)


select 
case when landing_page in('home','lander 1','lander 2','lander 3','lander 4') then 'Landing B' else 'Landing A'
end as landing_page,
case when viewed= 1 then 'Yes' else 'No' end as Bounced
from view_number 
```
 ## View full Sql script here 
 [Download SQL Script](sql/LandingPageAnalysis.sql)
 [Download SQL Script](sql/Landing-page-psql.sql)
 
---

## Data Preparation & Analysis Approach
- Performed data cleaning and transformation using SQL:
  - Removed duplicates
  - Handled missing values
  - Joined multiple raw tables into a unified dataset
  - Created calculated fields using SQL aggregations and transformations
- Used Excel to inspect and validate multiple joined tables before and after transformation
- Built an interactive landing page performance dashboard in Power BI
- Segmented data by:
  - Landing pages (Home Page, Lander 1–5)
  - Device type (Mobile vs Desktop)
  - Traffic sources (Bing, Facebook, Social)
- Conducted statistical analysis:
  - Chi-Square test for landing page performance differences
  - Hypothesis testing for conversion and bounce rates

---

## Dashboard Preview

![Landing Page Performance Dashboard](image/Dashboard.png)

---

## Key Insights
- Statistically significant differences exist between landing pages (p-value < 0.05)
- Lander 5 was the top-performing page:
  - Conversion Rate: **10.17%**
  - Bounce Rate: **36.87%**
- Mobile users showed higher bounce rates compared to desktop users

---

## Statistical Validation

### Chi-Square Test

The Chi-Square test was conducted across all landing pages to determine whether statistically significant performance differences existed between pages.

![Chi-Square Test](image/chisq-test.png)

### Bounce Rate Hypothesis Test

A hypothesis test was conducted to compare the bounce rate of Lander 5 against the average bounce rate of the remaining landing pages.

![Bounce Rate Hypothesis Test](image/Hypothesis-test-Bounce-rate.png)

### Conversion Rate Hypothesis Test

A second hypothesis test was conducted to validate whether Lander 5 achieved a statistically higher conversion rate than the other landing pages.

![Conversion Rate Hypothesis Test](image/Hypothesis-test.png)

---

## Business Impact
- Estimated **$1.18M potential revenue loss** due to underperforming landing pages
- Identified optimization opportunities in UX and messaging
- Recommended reallocating traffic toward high-performing landing pages to improve overall conversion rate

---

## Outcome
This project demonstrates how SQL-driven data preparation, Excel-based validation, and Power BI visualization can work together to generate actionable business insights that directly impact conversion performance and revenue.

---

## Project Files

### SQL Scripts
- SQL scripts used for data cleaning, joins, transformation, and KPI generation are included in this repository.

### Dashboard & Supporting Documents
- Dashboard screenshots
- Statistical validation outputs
- PDF reports

---

## Next Step
Currently expanding skills into Python for:
- Data cleaning automation
- ETL pipelines
- Advanced analytics workflows
