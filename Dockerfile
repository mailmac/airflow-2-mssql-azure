FROM python:3.8-slim-buster

ARG AIRFLOW_USER_HOME=/airflow
ARG AIRFLOW_VERSION=2.0.0
ENV AIRFLOW_HOME=${AIRFLOW_USER_HOME}

RUN apt-get update && apt-get install -y \
    unixodbc \
    unixodbc-dev \
    freetds-dev \
    freetds-bin \
    tdsodbc \
    --reinstall build-essential

RUN apt-get install gcc unixodbc-dev gnupg2 apt-transport-https curl -y \
  && curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - \
  && curl https://packages.microsoft.com/config/debian/9/prod.list > /etc/apt/sources.list.d/mssql-release.list 
RUN apt-get update
RUN ACCEPT_EULA=Y apt-get install msodbcsql17 -y
RUN ACCEPT_EULA=Y apt-get install mssql-tools -y
RUN echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bashrc

RUN echo "[ODBC Driver 17 for SQL Server]\n\
Description = Microsoft ODBC Driver 17 for SQL Server\n\
Driver = /opt/microsoft/msodbcsql17/lib64/libmsodbcsql-17.6.so.1.1\n\
UsageCount=1" >> /etc/odbcinst.ini

RUN pip install apache-airflow[postgres,odbc,mssql]==${AIRFLOW_VERSION}

COPY scripts/start-airflow.sh /start-airflow.sh
COPY dags /dags/

EXPOSE 8080

WORKDIR ${AIRFLOW_USER_HOME}
RUN chmod +x /start-airflow.sh
ENTRYPOINT ["/start-airflow.sh"]