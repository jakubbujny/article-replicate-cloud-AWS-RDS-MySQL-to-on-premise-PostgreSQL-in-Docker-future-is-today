#!/usr/bin/env bash

rds_endpoint=$(cat rds-endpoint)
docker run -it -v rds.sql:/rds.sql --rm mysql mysql -h$rds_endpoint -umymysql -pmysqlmysql mydb < /rds.sql