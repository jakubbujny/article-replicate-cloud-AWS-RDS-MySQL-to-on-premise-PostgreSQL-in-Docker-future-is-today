#!/usr/bin/env bash

../kubectl.sh apply -f zookeeper.yaml

public_node_ip=$(../fetch-node-public-ip.sh | tr -d '"')

cat kafka.yaml | sed --expression="s/PUBLIC_NODE_IP/$public_node_ip/g" | ../kubectl.sh apply -f