variable "channel" {
  default     = "stable"
  description = "Channel used to download the operator"
}

variable "operator_source" {
  default = "community-operators"
}

variable "sourceNamespace" {
  default     = "openshift-marketplace"
  description = "Marketplace used to download the operator"
}

variable "startingCSV" {
  default     = "strimzi-cluster-operator.v0.31.1"
  description = "Version to install"
}
