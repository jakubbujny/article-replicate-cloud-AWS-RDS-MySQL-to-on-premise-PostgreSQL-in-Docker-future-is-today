#!/usr/bin/env bash

cd aws

terraform apply

terraform output kubeconfig > ../kubeconfig.yaml

terraform output config-map-aws-auth > ../config-map-aws-auth.yaml

terraform output rds-endpoint > ../sql-scripts/rds-endpoint

cd ..

./kubectl.sh apply -f config-map-aws-auth.yaml

./kubectl.sh apply -f aws/eks-admin-service-account.yaml

./kubectl.sh apply -f aws/eks-admin-cluster-role-binding.yaml

./kubectl.sh apply -f https://raw.githubusercontent.com/kubernetes/dashboard/master/src/deploy/recommended/kubernetes-dashboard.yaml