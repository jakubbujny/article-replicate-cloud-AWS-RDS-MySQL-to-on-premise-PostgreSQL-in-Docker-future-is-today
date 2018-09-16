#!/usr/bin/env bash

./get-admin-token.sh

echo "Dashboard url: http://localhost:8001/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy/#!/login"

./kubectl.sh proxy