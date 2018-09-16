#!/usr/bin/env bash

aws --region eu-west-1 ec2 describe-instances --filters "Name=tag:Name,Values=eks" --filters "Name=instance-state-name,Values=running" --query "Reservations[0].Instances[0].PublicIpAddress"