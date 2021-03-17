from datetime import timedelta, datetime

import airflow
from airflow import DAG
from airflow.operators.bash_operator import BashOperator
from airflow.operators.mssql_operator import MsSqlOperator

default_args = {
    'owner': 'airflow',
    'depends_on_past': False,    
    'start_date': airflow.utils.dates.days_ago(2),
    'email': ['tonystark@superhero.org'],
    'email_on_failure': False,
    'email_on_retry': False,
    'retries': 1,
    'retry_delay': timedelta(minutes=5),
}

dag = DAG(
    'MS SQL test DAG', 
    default_args=default_args, 
    description = 'a simple dag with an MS SQL operator',
    schedule_interval=timedelta(days=1),
    )

t1 = BashOperator(
    task_id='print_date',
    depends_on_past=False,
    bash_command='date',
    dag=dag
)

t2 = MsSqlOperator(
    task_id='sql-op',
    mssql_conn_id='mssql_default',
    depends_on_past=False,
    sql='select * from schema.table',
    dag=dag
)

t1 >> t2
