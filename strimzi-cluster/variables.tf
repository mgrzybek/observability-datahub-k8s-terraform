variable "kafka_cluster_name" {
  type        = string
  description = "Name of the cluster to deploy"
}

variable "namespace" {
  type        = string
  description = "Namespace used to deploy the cluster"
}

variable "default_replication_factor" {
  type        = number
  default     = 1
  description = "The given value must be lesser than the number of workers (kafka_replicas)"
}

variable "inter_broker_protocol_version" {
  type        = string
  default     = "3.2"
  description = "Kafka protocol used for inter-broker communication"
}

variable "min_insync_replicas" {
  type        = number
  default     = 1
  description = "The given value must be lesser than the number of workers (kafka_replicas)"
}

variable "offsets_topic_replication_factor" {
  type        = number
  default     = 1
  description = "The given value must be lesser than the number of workers (kafka_replicas)"
}

variable "transaction_state_log_min_isr" {
  type        = number
  default     = 1
  description = "The given value must be lesser than the number of workers (kafka_replicas)"
}

variable "transaction_state_log_replication_factor" {
  type        = number
  default     = 1
  description = "The given value must be lesser than the number of workers (kafka_replicas)"
}

variable "kafka_replicas" {
  type        = number
  default     = 1
  description = "Number of data nodes to deploy"

  validation {
    condition     = var.kafka_replicas > 0
    error_message = "The value has to be greater than 0"
  }
}

variable "kafka_version" {
  type        = string
  default     = "3.2.3"
  description = "Kafka version to deploy"
}

variable "zk_replicas" {
  type        = number
  default     = 1
  description = "Number of Zookeeper instances to deploy"

  validation {
    condition     = var.zk_replicas == 1 || (var.zk_replicas > 0 && var.zk_replicas / 2 != ceil(var.zk_replicas / 2))
    error_message = "The value has to be an odd number"
  }
}
