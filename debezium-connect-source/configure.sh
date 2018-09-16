#!/usr/bin/env bash

public_node_ip=$(../fetch-node-public-ip.sh | tr -d '"')
curl -i -X POST -H "Accept:application/json" -H "Content-Type:application/json"  -d @source.json http://$public_node_ip:30001/connectors/