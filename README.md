# airflow-2-mssql-azure

You must first set up an Airflow Connection to connect to SQL. Here are the steps:

1. In the Airflow UI, click on Admin -> Connections
2. Click Edit button on Conn Id: mssql_default
3. Enter the following settings:

Conn Type: ODBC
Host: yourserver.database.windows.net
Schema: YourDefaultDatabase
Login: YourLogin
Password: YourPassword
Port: 1433
Extra:
{
  "Driver": "ODBC Driver 17 for SQL Server"
}

4. Save settings
