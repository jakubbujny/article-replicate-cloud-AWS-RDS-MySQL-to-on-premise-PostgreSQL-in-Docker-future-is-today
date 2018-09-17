#!/usr/bin/env bash

export PUBLIC_NODE_IP=$(../fetch-node-public-ip.sh | tr -d '"')

docker-compose "$@"