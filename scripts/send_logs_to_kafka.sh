ns=$(terraform show -json  | jq -r '.values.root_module.resources[] | select(.type|IN("kubernetes_namespace")).values.id')
bootstrap=$(terraform state show module.splitter.kubernetes_config_map.configmap | awk '/bootstrap_servers/ {gsub("\"","");print $NF}' | head -n1)
topic=$(terraform state show module.splitter.kubernetes_config_map.configmap | fgrep -A2 topics | head -n2 | tail -n1 | awk '{gsub("\"","");print $1}')

kubectl -n $ns run kafka-producer -ti --image=quay.io/strimzi/kafka:0.32.0-kafka-3.3.1 --rm=true --restart=Never -- bin/kafka-console-producer.sh --bootstrap-server $bootstrap --topic $topic
