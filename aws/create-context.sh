#!/usr/bin/env bash

terraform output kubeconfig > kubeconfig.yaml

terraform output config-map-aws-auth > config-map-aws-auth.yaml