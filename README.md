# NBA Data Pipeline

**Portfolio Project - Data Engineering (Civica Software)**  
This project showcases my expertise in building an ELT pipeline for NBA data using modern data engineering tools like Snowflake, dbt, and Power BI. It demonstrates my ability to design scalable data architectures, implement transformations, and create impactful visualizations.

<img src="https://upload.wikimedia.org/wikipedia/en/thumb/0/03/National_Basketball_Association_logo.svg/1200px-National_Basketball_Association_logo.svg.png" alt="NBA Logo" width="50"/>

## Introduction

This project builds an **ELT pipeline** for NBA data using **Snowflake** and **dbt**, following the **Medallion Architecture** (Bronze, Silver, Gold). It transforms raw NBA data into optimized models for visualization in **Power BI**, enabling insights into game results, player performance, and team analytics.

## Solution Architecture

![NBA Architecture](https://github.com/user-attachments/assets/31abab79-cf03-47a7-8ee8-65e63018f005)

### **Pipeline Overview**:

- **Bronze Layer**: Raw data ingestion into Snowflake.
- **Silver Layer**: Data cleaning, deduplication, and advanced transformations using dbt.
- **Gold Layer**: Fact and dimension tables optimized for analytics and Power BI dashboards.

## Data Sources & Processing

### **Data Sources**

- [NBA Games Dataset](https://www.kaggle.com/datasets/nathanlauga/nba-games)
- [Common Player Info](https://www.kaggle.com/datasets/wyattowalsh/basketball)
- **Conference tables** (manually created).


### **Processing Layers**:
1. **Bronze Layer**

    - CSV ingestion via Fivetran into Snowflake.
    - Performs basic type casting and light transformations (Bases).

![sources + bases](https://github.com/user-attachments/assets/86da7f6a-009e-42c9-9540-fc00b70bef63)

2. **Silver Layer**

    - Cleans and transforms data using dbt.
    - Key components:
        - **Stages**: Primary key generation, data casting, deduplication, and custom macros (Game Type Classification, PER calculation).
  
      ![Source-Base-STG](https://github.com/carleondel/nba_data_engineering/assets/140411658/14b195fc-035d-4c90-b867-1c714891a045)
      
        - **Intermediate Layer**: Combines stages into a unified fact table for further analysis.

          **Key Macros**
            - **PER Calculation**
           ![PER Macro](https://github.com/carleondel/nba_data_engineering/assets/140411658/14510df0-7163-49d5-9165-c46eff8d4a5d)
  
            - **Game Type Classification**

            ![Game Type Macro](https://github.com/carleondel/nba_data_engineering/assets/140411658/904a2deb-6e61-4b73-9fac-0de01f7d6261)

            - **Incremental Model (Conferences)**
      
            ![Conferences Incremental](https://github.com/carleondel/nba_data_engineering/assets/140411658/08c7c9c0-0fc8-461c-9c9d-3fef3dc81729)




3. **Gold Layer**

    - Builds optimized **fact** and dimension **tables** for analytics.
    - Includes **core** dimensions (e.g., date dimension via dbt_date) and **marts** (pre-aggregated datasets) for Power BI visualizations.

![Modelo Dimensional](https://github.com/user-attachments/assets/bd249e2c-bd39-4673-8692-2208fb4f8d47)

      
### dbt Lineage

![DAG final](https://github.com/user-attachments/assets/f5404d7f-85c1-47b5-add1-2c34a1b0c9af)



## Testing & Documentation

### Testing

- Generic tests ensure primary key integrity and relational consistency.

![Documentation & Tests](https://github.com/carleondel/nba_data_engineering/assets/140411658/e60f095f-0438-4d1d-a6ad-2050c9fbe14b)

### Documentation

- Field descriptions in `.yml` files for clarity and maintainability.

## Visualizations

### Top 10 Regular Season Performances (2009-2019)

![Top 10 Regular Season](https://github.com/carleondel/nba_data_engineering/assets/140411658/162bd2c5-f84c-4284-88f6-98266a9bb7a1)

### Top Playoff Teams (2009-2019)

![Top Playoff Teams](https://github.com/carleondel/nba_data_engineering/assets/140411658/a176f4d0-1c86-4226-9e60-eb8c472c4d84)

### NBA Insights Dashboard

![Dashboard](https://github.com/user-attachments/assets/d4077d3b-c2f7-4e1f-badc-6e175f5147a8)
