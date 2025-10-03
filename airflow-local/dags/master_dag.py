from airflow import DAG
from airflow.operators.trigger_dagrun import TriggerDagRunOperator
from datetime import datetime

default_args = {"retries": 0}

PIPELINE_GROUPS = {
    "EcommercePipeline": [
        "el-ecommerce",
        "dbt-ecommerce",
    ],
}

with DAG(
    dag_id="controller_master_khaled_parallel",
    default_args=default_args,
    description="Master DAG with parallel pipeline execution for ecommerce",
    schedule_interval=None,
    start_date=datetime(2025, 9, 1),
    catchup=False,
) as dag:

    for group_name, dags in PIPELINE_GROUPS.items():
        previous_task = None
        for dag_id in dags:
            task = TriggerDagRunOperator(
                task_id=f"trigger_{dag_id}",
                trigger_dag_id=dag_id,
                reset_dag_run=True,
                wait_for_completion=True,
                poke_interval=10,
            )

            if previous_task:
                previous_task >> task 

            previous_task = task
