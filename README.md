# Landing Page Performance Analysis

Landing page performance analysis using SQL, Excel, and Power BI to identify conversion drivers, bounce rate issues, and revenue optimization opportunities.

---

# Landing Page Performance Analysis  
SQL • Excel • Power BI • Statistical Analysis

---

## Overview
This project analyzes landing page performance for an e-commerce platform using SQL, Excel, and Power BI. The goal is to identify conversion drivers, bounce rate issues, and revenue optimization opportunities.

---

## Business Problem
The e-commerce platform **Mr Fuzzy Teddy Bear** experienced inconsistent landing page performance, resulting in:

- High bounce rates on certain landing pages  
- Uneven conversion rates across traffic sources  
- Lost revenue opportunities  

---

## Objective
The objective of this analysis is to:

- Identify best and worst performing landing pages  
- Measure conversion rate and bounce rate differences  
- Understand user behavior across devices and traffic sources  
- Identify opportunities for revenue optimization  

---

## Data Source
This project uses a public dataset from Maven Analytics as part of a data analytics challenge.

Source: https://www.mavenanalytics.io/data-playground

---

## Tools & Technologies
- SQL → Data cleaning, transformation, joins, aggregations  
- Excel → Data validation and statistical testing  
- Power BI → Dashboard development and KPI visualization  
- Statistics → Chi-square test, hypothesis testing  

---

## Dataset Overview
The dataset includes:

- Website session-level interaction data  
- Multiple landing pages (Home, Lander 1–5)  
- Traffic sources (Bing, Facebook, Social, etc.)  
- Device types (Mobile, Desktop)  

---

## Project Files

### SQL Scripts
- Landing Page Analysis SQL (`sql/LandingPageAnalysis.sql`)  
- Power BI Reporting SQL (`sql/Landing-page-psql.sql`)  

### Supporting Files
- Full project assets (Excel files, dashboards, reports):  
  https://drive.google.com/drive/folders/1KIKdlMwQxnAs7cOSX3haqWUeD6BB6Fyc?usp=drive_link  

---

## Data Workflow

### 1. Data Preparation (SQL)
- Removed duplicates  
- Handled missing values  
- Joined multiple raw tables into a unified dataset  
- Created calculated fields for analysis  

---

### 2. Data Validation (Excel)
- Verified cleaned datasets  
- Cross-checked transformed tables  
- Validated statistical outputs before analysis  

---

### 3. Reporting Layer (Power BI)
- Built interactive dashboards  
- Created KPIs:
  - Conversion rate  
  - Bounce rate  
  - Landing page performance metrics  

---

### 4. Segmentation Analysis
Data was segmented by:

- Landing pages (Home Page, Lander 1–5)  
- Device type (Mobile vs Desktop)  
- Traffic sources (Bing, Facebook, Social)  

---

### 5. Statistical Analysis
- Chi-square test to determine landing page performance differences  
- Hypothesis testing for bounce rate and conversion rate validation  

---

## SQL Example

```sql
WITH view_number AS (
    SELECT 
        h.website_session_id,
        btrim(regexp_replace(h.pageview_url,'[^a-zA-Z0-9]',' ','g')) AS landing_page,
        COUNT(wp.*) AS viewed
    FROM homepage h
    INNER JOIN website_pageviews wp
        ON h.website_session_id = wp.website_session_id
    GROUP BY 1,2
)

SELECT 
    CASE 
        WHEN landing_page IN ('home','lander 1','lander 2','lander 3','lander 4') 
        THEN 'Landing B' 
        ELSE 'Landing A' 
    END AS landing_group,

    CASE 
        WHEN viewed = 1 THEN 'Yes'
        ELSE 'No'
    END AS bounced
FROM view_number;
```

---


 ## SQL Scripts & Project Files

### View Full SQL Scripts
- [Excel Statistical Prep SQL](sql/LandingPageAnalysis.sql)
- [Power BI Reporting SQL](sql/Landing-page-psql.sql)

---

## Data Preparation & Analysis Approach

This project followed a structured analytics workflow combining SQL, Excel, and Power BI.

### 1. Data Engineering (SQL Layer)
- Performed data cleaning and transformation using SQL:
  - Removed duplicates
  - Handled missing values
  - Joined multiple raw tables into a unified dataset
  - Created calculated fields using SQL aggregations and transformations

### 2. Data Validation (Excel Layer)
- Used Excel to inspect and validate multiple joined tables
- Verified correctness of transformed datasets before analysis

### 3. BI & Visualization Layer (Power BI)
- Built an interactive landing page performance dashboard
- Created KPIs and performance visuals

### 4. Segmentation Analysis
Data was segmented by:
- Landing pages (Home Page, Lander 1–5)
- Device type (Mobile vs Desktop)
- Traffic sources (Bing, Facebook, Social)

### 5. Statistical Analysis
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
The Chi-Square test was conducted to determine whether performance differences between landing pages were statistically significant.

![Chi-Square Test](image/chisq-test.png)

---

### Bounce Rate Hypothesis Test
A hypothesis test was used to compare Lander 5 bounce rate against all other landing pages.

![Bounce Rate Hypothesis Test](image/Hypothesis-test-Bounce-rate.png)

---

### Conversion Rate Hypothesis Test
A hypothesis test was conducted to validate whether Lander 5 achieved a significantly higher conversion rate.

![Conversion Rate Hypothesis Test](image/Hypothesis-test.png)

---

## Business Impact

- Estimated **$1.18M revenue opportunity identified**
- Clear UX and landing page optimization opportunities discovered
- Recommended reallocating traffic toward high-performing landing pages to improve conversion rates

---

## Outcome

This project demonstrates how SQL-driven data preparation, Excel validation, and Power BI visualization work together to generate actionable business insights that directly improve conversion performance and revenue.

---

## Project Files

### SQL Scripts
- SQL scripts for data cleaning, transformation, joins, and KPI generation are included in this repository.

### Supporting Files
- Dashboard screenshots
- Statistical validation outputs
- PDF reports

---

## Next Step

Currently expanding into Python for:
- Data cleaning automation
- ETL pipelines
- Advanced analytics workflows

---

## Contact
- LinkedIn: https://www.linkedin.com/in/emeka-ike-108748198/
- Email: ikeernest4700@gmail.com
- Open to entry-level Data Analyst roles, collaborations, or feedback

    end as Bounced
from view_number;
