#!/usr/bin/env bash

is_running=$(minikube status | grep Running | wc -l)
[[ ! $is_running -eq 2 ]] && minikube start

ssh -o StrictHostKeyChecking=no -t -i  ~/.minikube/machines/minikube/id_rsa docker@$(minikube ip) "sudo mkdir -p /mnt/kafka-data"

ssh -o StrictHostKeyChecking=no -t -i ~/.minikube/machines/minikube/id_rsa docker@$(minikube ip) "sudo mkdir -p /mnt/zookeeper-data"

ssh -o StrictHostKeyChecking=no -t -i ~/.minikube/machines/minikube/id_rsa docker@$(minikube ip) "sudo mkdir -p /mnt/zookeeper-conf"

ssh -o StrictHostKeyChecking=no -t -i  ~/.minikube/machines/minikube/id_rsa docker@$(minikube ip) "sudo mkdir -p /mnt/postgres-data"

kubectl apply -f storage-class.yaml

kubectl apply -f kafka/zookeeper.yaml

kubectl apply -f kafka/kafka.yaml

kubectl apply -f postgres/postgres.yaml