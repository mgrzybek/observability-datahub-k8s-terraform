resource "kubernetes_manifest" "subscription_strimzi_kafka_operator" {
  manifest = {
    "apiVersion" = "operators.coreos.com/v1alpha1"
    "kind"       = "Subscription"
    "metadata" = {
      "name"      = "strimzi-kafka-operator"
      "namespace" = "openshift-operators"
    }
    "spec" = {
      "channel"             = var.channel
      "installPlanApproval" = "Automatic"
      "name"                = "strimzi-kafka-operator"
      "source"              = var.operator_source
      "sourceNamespace"     = var.sourceNamespace
      "startingCSV"         = var.startingCSV
    }
  }
}

