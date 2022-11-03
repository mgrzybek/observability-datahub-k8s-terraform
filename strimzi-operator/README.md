# strimzi-operator

Installs the Strimzi Operator using the Openshift marketplace.


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
| [kubernetes_manifest.subscription_strimzi_kafka_operator](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/manifest) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_channel"></a> [channel](#input\_channel) | Channel used to download the operator | `string` | `"stable"` | no |
| <a name="input_operator_source"></a> [operator\_source](#input\_operator\_source) | n/a | `string` | `"community-operators"` | no |
| <a name="input_sourceNamespace"></a> [sourceNamespace](#input\_sourceNamespace) | Marketplace used to download the operator | `string` | `"openshift-marketplace"` | no |
| <a name="input_startingCSV"></a> [startingCSV](#input\_startingCSV) | Version to install | `string` | `"strimzi-cluster-operator.v0.31.1"` | no |

## Outputs

No outputs.
