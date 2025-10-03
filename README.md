# E-Commerce ELT Pipeline with Airflow, dbt, and BigQuery

## Overview
This project implements an end-to-end ELT pipeline for e-commerce dataset.  
It uses **Apache Airflow** for orchestration, **Google Cloud Storage (GCS)** and **BigQuery** for storage and processing, and **dbt** for data transformations.

The pipeline:
- Extracts raw data from Kaggle
- Loads it into BigQuery
- Transforms it into a star schema with dbt
- Publishes reporting views for downstream analytics

---

## Architecture

Kaggle → Airflow (EL DAG) → GCS → BigQuery (raw data)

↓

dbt (staging → marts → reporting)

↓

BigQuery analytics-ready views


---

## Project Structure

### Airflow DAGs (`/dags`)

- **`el-ecommerce`** (Extract and Load pipeline)  
  - Downloads dataset from Kaggle  
  - Unzips and uploads to GCS  
  - Loads into BigQuery (`ready-de27.khaled_projects.Demo-2-raw_vehicle_price_prediction`)  

- **`dbt-ecommerce`** (Transformation pipeline)  
  - Runs staging models (data cleaning, type casting, derived features)  
  - Runs marts (fact and dimension tables)  
  - Runs reporting models  

- **`master_dag`** (Controller DAG)  
  - Triggers both pipelines in sequence:  
    `el-vehicle_price_prediction → dbt-vehicle_price_prediction`
  - And is able to trigger other dags in parallel if needed.
---

### dbt Models (`/dbt/my_dbt_project/models`)

- **Staging (`/staging/`)**  
  - `Demo-1-stg_ecommerce.sql`  
    - Cleans and standardizes raw vehicle data    
    - Normalizes text fields, casts numeric fields  

- **Marts (`/marts/`)**  
  - Fact table: `Demo-1-fact_orders.sql`  
  - Dimension tables:  
    - `Demo-1-dim_products.sql`  
    - `Demo-1-dim_dates.sql`  
    - `Demo-1-dim_customers.sql`  

- **Reporting (`/reporting/`)**  
  - `Demo-1-sales_reporting.sql`  
    - Combines fact and dimension tables into an analytics-ready view  

  


