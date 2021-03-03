#!/usr/bin/env bash

airflow db init

airflow users create \
--username ${AIRFLOW_USER_USERNAME:="admin"} \
--firstname ${AIRFLOW_USER_FIRSTNAME:="Tony"} \
--lastname ${AIRFLOW_USER_LASTNAME:="Stark"} \
--role ${AIRFLOW_USER_ROLE:="Admin"} \
--email ${AIRFLOW_USER_EMAIL:="tonystark@superhero.org"} \
--password ${AIRFLOW_USER_PASSWORD:="12345"}

airflow scheduler &

exec airflow webserver
