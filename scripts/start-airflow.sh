#!/usr/bin/env bash

airflow db init

airflow users create \
--username admin \
--firstname Tony \
--lastname Stark \
--role Admin \
--email tonystark@superhero.org \
--password yourpw

airflow scheduler &

exec airflow webserver
