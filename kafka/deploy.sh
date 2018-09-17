#!/usr/bin/env bash

cd ..
./kubectl.sh apply -f kafka/zookeeper.yaml
cd kafka

public_node_ip=$(../fetch-node-public-ip.sh | tr -d '"')

kafka_file=$(cat kafka.yaml | sed --expression="s/NODE_PUBLIC_IP/$public_node_ip/g")

cd ..
echo "$kafka_file" | ./kubectl.sh apply -f -
