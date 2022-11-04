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

  namespace = var.namespace
  name      = var.techlogs_bucket
}

module "auditlogs" {
  depends_on = [kubernetes_namespace.logs]
  source     = "git::https://github.com/mgrzybek/terraform-module-k8s-bucket-claim"

  namespace = var.namespace
  name      = var.auditlogs_bucket
}

module "logs" {
  depends_on = [kubernetes_namespace.logs]
  source     = "git::https://github.com/mgrzybek/terraform-module-k8s-bucket-claim"

  namespace = var.namespace

  for_each = toset(var.source_topics)
  name     = each.key
}

module "operator" {
  source = "./strimzi-operator"

  isOpenshift     = true
  operatorSource  = "community-operator"
  sourceNamespace = "openshift-marketplace"
  startingCSV     = "strimzi-cluster-operator.v0.31.1"
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

  bootstrap_servers       = "${var.kafka_cluster_name}-kafka-bootstrap:9091"
  destination_audit_topic = var.auditlogs_topic
  destination_tech_topic  = var.techlogs_topic
  source_topics           = var.source_topics
}
