from airflow import DAG
from airflow.utils.dates import days_ago
from airflow.providers.google.cloud.transfers.local_to_gcs import LocalFilesystemToGCSOperator
from airflow.providers.google.cloud.transfers.gcs_to_bigquery import GCSToBigQueryOperator
from airflow.operators.bash import BashOperator

with DAG(
    "el-ecommerce",
    schedule_interval=None,
    start_date=days_ago(1),
    catchup=False,
) as dag:

    download_data = BashOperator(
        task_id="download_data",
        bash_command=(
            "kaggle datasets download -d miadul/e-commerce-sales-transactions-dataset "
            "-p /opt/airflow/data/"
        ),
    )

    unzip_data = BashOperator(
        task_id="unzip_data",
        bash_command="unzip -o /opt/airflow/data/*.zip -d /opt/airflow/data/"
    )

    upload_to_gcs = LocalFilesystemToGCSOperator(
        task_id="upload_to_gcs",
        src="/opt/airflow/data/ecommerce_sales_34500.csv",
        dst="Demo-1-raw/Demo-1-ecommerce_sales_34500.csv",
        bucket="khaled-bucket-demo",
        gcp_conn_id="google_cloud_default",  
    )

    load_to_bq = GCSToBigQueryOperator(
        task_id="load_to_bq",
        bucket="khaled-bucket-demo",
        source_objects=["Demo-1-raw/Demo-1-ecommerce_sales_34500.csv"],
        destination_project_dataset_table="ready-de27.khaled_projects.Demo-1-raw_ecommerce",
        source_format="CSV",
        skip_leading_rows=1,
        autodetect=True,
        write_disposition="WRITE_TRUNCATE",
        gcp_conn_id="google_cloud_default", 
    )

    download_data >> unzip_data >> upload_to_gcs >> load_to_bq
