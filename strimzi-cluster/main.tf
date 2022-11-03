resource "kubernetes_manifest" "kafka_cluster" {
  provisioner "local-exec" {
    command = "kubectl wait kafka/${var.kafka_cluster_name} --for=condition=Ready --timeout=600s -n ${var.namespace}"
  }

  manifest = {
    "apiVersion" = "kafka.strimzi.io/v1beta2"
    "kind"       = "Kafka"
    "metadata" = {
      "name"      = var.kafka_cluster_name
      "namespace" = var.namespace
    }
    "spec" = {
      "entityOperator" = {
        "topicOperator" = {}
        "userOperator"  = {}
      }
      "kafka" = {
        "config" = {
          "default.replication.factor"               = var.default_replication_factor
          "inter.broker.protocol.version"            = var.inter_broker_protocol_version
          "min.insync.replicas"                      = var.min_insync_replicas
          "offsets.topic.replication.factor"         = var.offsets_topic_replication_factor
          "transaction.state.log.min.isr"            = var.transaction_state_log_min_isr
          "transaction.state.log.replication.factor" = var.transaction_state_log_replication_factor
        }
        "listeners" = [
          {
            "name" = "plain"
            "port" = 9092
            "tls"  = false
            "type" = "internal"
          },
          {
            "name" = "tls"
            "port" = 9093
            "tls"  = true
            "type" = "internal"
          },
        ]
        "replicas" = var.kafka_replicas
        "storage" = {
          "type" = "ephemeral"
        }
        "version" = var.kafka_version
      }
      "zookeeper" = {
        "replicas" = var.zk_replicas
        "storage" = {
          "type" = "ephemeral"
        }
      }
    }
  }
}
