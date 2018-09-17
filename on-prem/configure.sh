#!/usr/bin/env bash

until curl --fail --max-time 5 -H "Accept:application/json" localhost:8083/ ; do
    echo "Waiting for debezium to be available"
    sleep 2
done


curl -i -X POST -H "Accept:application/json" -H "Content-Type:application/json"  -d @sink.json http://localhost:8083/connectors/