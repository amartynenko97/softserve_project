#!/bin/bash

while ! "Service Broker manager has started." /var/opt/mssql/log/errorlog*
do
sleep 5s
echo "waiting for SQL sever..."
done

/opt/mssql-tools/bin/sqlcmd -S localhost -U SA P "ARandomPassword123!" -i /SQL/restoredatabase_1.sql
/opt/mssql-tools/bin/sqlcmd -S localhost -U SA P "ARandomPassword123!" -i /SQL/restoredatabase_2.sql
