variable "namespace" {
  type        = string
  description = "The namespace used to deploy the module"
}

variable "kafka_cluster_name" {
  type        = string
  default     = "kafka-logs"
  description = "Name of the cluster created"
}

variable "kafka_data_size" {
  type        = string
  default     = "1Gi"
  description = "Size of the PV claimed to store Kafka’s data"

  validation {
    condition     = regex("[[:digit:]]+[[:alpha:]]+", var.kafka_data_size) == var.kafka_data_size
    error_message = "The value has to be a number followed by a unit"
  }
}

variable "kafka_replicas" {
  type        = number
  default     = 1
  description = "Number of data nodes deployed"
}

variable "zk_data_size" {
  type        = string
  default     = "1Gi"
  description = "Size of the PV claimed to store Zookeeper’s data"

  validation {
    condition     = regex("[[:digit:]]+[[:alpha:]]+", var.zk_data_size) == var.zk_data_size
    error_message = "The value has to be a number followed by a unit"
  }
}

variable "zk_replicas" {
  type        = number
  default     = 1
  description = "Number of pods deployed for Zookeeper"
}
