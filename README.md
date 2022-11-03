# observability-datahub-k8s-terraform
Read logs and metrics from Kafka topics and send them to S3, split GPDR logs and tech logs

## How it works

![Workflow diagram](./diagrams/workflow.svg)

The *logs* topic contains json-based messages. Two key fields are used:
* `log_type` from the main message
* `_log_type` in the nested json-based data within `message`

If their value is *application*, then the nested json is extracted to the main message and the field is tested.

```json
{
    "log_type":"application",
    "message":"{\"_log_type\":\"audit\",\"message\":\"Hello World from app !\"}"
}
```

If their value is *audit*, then the message is routed to the *auditlogs* topic.

```json
{
    "log_type":"audit",
    "message":"Hello World from audit !"
}
```
## How to use it

Each resource is a terraform-based module:

* [logs-splitter-logstash](https://github.com/mgrzybek/terraform-module-k8s-logstash-logs-splitter): deploys a logstash service that splits the logs.
* [k8s-bucket-claim](https://github.com/mgrzybek/terraform-module-k8s-bucket-claim): creates s3 buckets using the Openshift storage operator.
* [strimzi-operator](./strimzi-operator): installs the Strimzi Kafka operator using the Openshift marketpace (Operator Subscription).
* [strimzi-cluster](./strimzi-claster): installs a Kafka cluster using the operator just installed before.
* logs-to-s3: *in progress*, will be based on a Fluentd agent using Kafka and S3 modules. We need to create a custom container because this is not included in the official release. See https://github.com/mgrzybek/fluentd-kafka-s3-logs-archiver

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | 2.14.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_auditlogs"></a> [auditlogs](#module\_auditlogs) | git::https://github.com/mgrzybek/terraform-module-k8s-bucket-claim | n/a |
| <a name="module_cluster"></a> [cluster](#module\_cluster) | ./strimzi-cluster | n/a |
| <a name="module_logs"></a> [logs](#module\_logs) | git::https://github.com/mgrzybek/terraform-module-k8s-bucket-claim | n/a |
| <a name="module_operator"></a> [operator](#module\_operator) | ./strimzi-operator | n/a |
| <a name="module_splitter"></a> [splitter](#module\_splitter) | git::https://github.com/mgrzybek/terraform-module-k8s-logstash-logs-splitter | n/a |
| <a name="module_techlogs"></a> [techlogs](#module\_techlogs) | git::https://github.com/mgrzybek/terraform-module-k8s-bucket-claim | n/a |

## Resources

| Name | Type |
|------|------|
| [kubernetes_namespace.logs](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_kafka_cluster_name"></a> [kafka\_cluster\_name](#input\_kafka\_cluster\_name) | Name of the cluster created | `string` | `"kafka-logs"` | no |
| <a name="input_kafka_data_size"></a> [kafka\_data\_size](#input\_kafka\_data\_size) | Size of the PV claimed to store Kafka’s data | `string` | `"1Gi"` | no |
| <a name="input_kafka_replicas"></a> [kafka\_replicas](#input\_kafka\_replicas) | Number of data nodes deployed | `number` | `1` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | The namespace used to deploy the module | `string` | n/a | yes |
| <a name="input_zk_data_size"></a> [zk\_data\_size](#input\_zk\_data\_size) | Size of the PV claimed to store Zookeeper’s data | `string` | `"1Gi"` | no |
| <a name="input_zk_replicas"></a> [zk\_replicas](#input\_zk\_replicas) | Number of pods deployed for Zookeeper | `number` | `1` | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
