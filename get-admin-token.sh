#!/usr/bin/env bash

./kubectl.sh apply -f aws/eks-admin-service-account.yaml

./kubectl.sh apply -f aws/eks-admin-cluster-role-binding.yaml

./kubectl.sh -n kube-system describe secret $(./kubectl.sh -n kube-system get secret | grep eks-admin | awk '{print $1}') | grep token