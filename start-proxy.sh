#!/usr/bin/env bash

./kubectl.sh -n kube-system describe secret $(./kubectl.sh -n kube-system get secret | grep eks-admin | awk '{print $1}') | grep token

echo "Dashboard url: http://localhost:8001/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy/#!/login"

./kubectl.sh proxy