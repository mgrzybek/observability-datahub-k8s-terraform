#####################################################
# Kubernetes
#
variable "name" {
  type        = string
  description = "Name and prefix of the created objects"
}

variable "namespace" {
  type        = string
  description = "The namespace used to install bucket"
}

variable "number" {
  type        = number
  description = "Number of pods to start"
  default     = 1
}

#####################################################
# Kafka
#
variable "bootstrap_servers" {
  type        = string
  description = "host:port,"
}

variable "destination_audit_topic" {
  type        = string
  description = "The topic to write the audit logs into"
}

variable "destination_tech_topic" {
  type        = string
  description = "The topic to write the tech logs into"
}

variable "source_topics" {
  type        = list(string)
  description = "A list a topics to read from"
}

#####################################################
# Logs management
#
variable "log_key" {
  type        = string
  description = "JSON field to check"
  default     = "log_type"
}

variable "log_value" {
  type        = string
  description = "The key value used to split the messages"
  default     = "audit"
}

variable "nested_log_key" {
  type        = string
  description = "Nested JSON field to check"
  default     = "_log_type"
}

variable "nested_log_value" {
  type        = string
  description = "The key value used to split the messages"
  default     = "audit"
}

variable "log_value_with_nested_json" {
  type        = string
  description = "The key value indicating that a nested json exists"
  default     = "application"
}

variable "log_key_with_nested_json" {
  type        = string
  description = "The key value containing nested json data"
  default     = "message"
}
