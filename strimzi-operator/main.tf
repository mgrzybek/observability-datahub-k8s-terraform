resource "kubernetes_manifest" "subscription_strimzi_kafka_operator" {
  manifest = yamldecode(templatefile(
    "${path.module}/operator.tmpl.yml",
    {
      channel         = var.channel
      operatorSource  = var.operatorSource
      sourceNamespace = var.sourceNamespace
      startingCSV     = var.startingCSV
      isOpenshift     = var.isOpenshift
    }
  ))
}

