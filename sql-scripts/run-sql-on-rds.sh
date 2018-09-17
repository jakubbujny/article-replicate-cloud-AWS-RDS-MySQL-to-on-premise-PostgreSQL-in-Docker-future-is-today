#!/usr/bin/env bash

rds_endpoint=$(cat rds-endpoint)
rds_endpoint_without_port=${rds_endpoint::-5}
sql=$(cat rds.sql)
docker run -it  --rm mysql bash -c "echo '$sql' | mysql -h${rds_endpoint_without_port} -umymysql -pmysqlmysql mydb"