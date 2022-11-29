#! /usr/bin/env bash

ns=$(terraform show -json  | jq -r '.values.root_module.resources[] | select(.type|IN("kubernetes_namespace")).values.id')
pod=$(kubectl get pods -n $ns | awk "/archiver/ {print \$1}")

kubectl logs $pod -n $ns -f