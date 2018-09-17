#!/usr/bin/env bash

public_node_ip=$(../fetch-node-public-ip.sh | tr -d '"')


until curl --fail --max-time 5 -H "Accept:application/json" $public_node_ip:30001/ ; do
    echo "Waiting for debezium to be available"
    sleep 2
done


curl -i -X POST -H "Accept:application/json" -H "Content-Type:application/json"  -d @source.json http://$public_node_ip:30001/connectors/