variable "channel" {
  default     = "stable"
  description = "Channel used to download the operator"
}

variable "operatorSource" {
  default = "operatorhubio-catalog"
}

variable "sourceNamespace" {
  default     = "olm"
  description = "Marketplace used to download the operator"
}

variable "startingCSV" {
  default     = "strimzi-cluster-operator.v0.31.1"
  description = "Version to install"
}

variable "isOpenshift" {
  type        = bool
  default     = false
  description = "Is it deployed on Openshift?"
}
