resource "kubernetes_namespace" "logs" {
  metadata {
    annotations = {
      name = var.namespace
    }
    name = var.namespace
  }
}

module "techlogs" {
  depends_on = [kubernetes_namespace.logs]
  source     = "git::https://github.com/mgrzybek/terraform-module-k8s-bucket-claim"

  namespace    = var.namespace
  storageClass = var.storage_class
  name         = var.techlogs_bucket
}

module "auditlogs" {
  depends_on = [kubernetes_namespace.logs]
  source     = "git::https://github.com/mgrzybek/terraform-module-k8s-bucket-claim"

  namespace    = var.namespace
  storageClass = var.storage_class
  name         = var.auditlogs_bucket
}

module "operator" {
  source = "./strimzi-operator"

  isOpenshift     = var.isOpenshift
  operatorSource  = var.operatorSource
  sourceNamespace = var.sourceNamespace
  startingCSV     = var.startingCSV
}

module "cluster" {
  depends_on = [kubernetes_namespace.logs]
  source     = "./strimzi-cluster"

  kafka_cluster_name = var.kafka_cluster_name
  kafka_replicas     = var.kafka_replicas
  zk_replicas        = var.zk_replicas
  namespace          = var.namespace
}

module "splitter" {
  depends_on = [
    module.techlogs,
    module.auditlogs,
    module.logs,
    module.cluster
  ]
  source = "git::https://github.com/mgrzybek/terraform-module-k8s-logstash-logs-splitter"

  name      = "splitter"
  namespace = var.namespace
  number    = var.splitter_replicas

  bootstrap_servers       = "${var.kafka_cluster_name}-kafka-bootstrap:9092"
  destination_audit_topic = var.auditlogs_topic
  destination_tech_topic  = var.techlogs_topic
  source_topics           = var.source_topics
}
