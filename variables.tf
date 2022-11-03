variable "namespace" {
  type        = string
  description = "The namespace used to deploy the module"
}

variable "kafka_cluster_name" {
  type    = string
  default = "kafka-logs"
}

variable "kafka_data_size" {
  type    = string
  default = "1Gi"
}

variable "kafka_replicas" {
  type    = number
  default = 1
}

variable "zk_data_size" {
  type    = string
  default = "1Gi"
}

variable "zk_replicas" {
  type    = number
  default = 1
}
