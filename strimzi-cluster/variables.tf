variable "kafka_cluster_name" {
  type = string
}
variable "namespace" {
  type = string
}
variable "default_replication_factor" {
  type    = number
  default = 1
}
variable "inter_broker_protocol_version" {
  type    = string
  default = "3.2"
}
variable "min_insync_replicas" {
  type    = number
  default = 1
}
variable "offsets_topic_replication_factor" {
  type    = number
  default = 1
}
variable "transaction_state_log_min_isr" {
  type    = number
  default = 1
}
variable "transaction_state_log_replication_factor" {
  type    = number
  default = 1
}
variable "kafka_replicas" {
  type    = number
  default = 1
}
variable "kafka_version" {
  type    = string
  default = "3.2.3"
}
variable "zk_replicas" {
  type    = number
  default = 1
}
