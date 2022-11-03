# strimzi-cluster

Creates a kafka cluster in the provided namespace using the operator.

## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [kubernetes_manifest.kafka_cluster](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/manifest) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_default_replication_factor"></a> [default\_replication\_factor](#input\_default\_replication\_factor) | The given value must be lesser than the number of workers (kafka\_replicas) | `number` | `1` | no |
| <a name="input_inter_broker_protocol_version"></a> [inter\_broker\_protocol\_version](#input\_inter\_broker\_protocol\_version) | n/a | `string` | `"3.2"` | no |
| <a name="input_kafka_cluster_name"></a> [kafka\_cluster\_name](#input\_kafka\_cluster\_name) | n/a | `string` | n/a | yes |
| <a name="input_kafka_replicas"></a> [kafka\_replicas](#input\_kafka\_replicas) | n/a | `number` | `1` | no |
| <a name="input_kafka_version"></a> [kafka\_version](#input\_kafka\_version) | n/a | `string` | `"3.2.3"` | no |
| <a name="input_min_insync_replicas"></a> [min\_insync\_replicas](#input\_min\_insync\_replicas) | The given value must be lesser than the number of workers (kafka\_replicas) | `number` | `1` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | n/a | `string` | n/a | yes |
| <a name="input_offsets_topic_replication_factor"></a> [offsets\_topic\_replication\_factor](#input\_offsets\_topic\_replication\_factor) | The given value must be lesser than the number of workers (kafka\_replicas) | `number` | `1` | no |
| <a name="input_transaction_state_log_min_isr"></a> [transaction\_state\_log\_min\_isr](#input\_transaction\_state\_log\_min\_isr) | The given value must be lesser than the number of workers (kafka\_replicas) | `number` | `1` | no |
| <a name="input_transaction_state_log_replication_factor"></a> [transaction\_state\_log\_replication\_factor](#input\_transaction\_state\_log\_replication\_factor) | The given value must be lesser than the number of workers (kafka\_replicas) | `number` | `1` | no |
| <a name="input_zk_replicas"></a> [zk\_replicas](#input\_zk\_replicas) | n/a | `number` | `1` | no |

## Outputs

No outputs.
