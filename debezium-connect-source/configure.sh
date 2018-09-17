#!/usr/bin/env bash

public_node_ip=$(../fetch-node-public-ip.sh | tr -d '"')

is_debezium_ready () { curl --fail -H "Accept:application/json" $public_node_ip:8083/ }

until is_debezium_ready; do
    echo "Waiting for debezium to be available"
    sleep 2
done


curl -i -X POST -H "Accept:application/json" -H "Content-Type:application/json"  -d @source.json http://$public_node_ip:30001/connectors/