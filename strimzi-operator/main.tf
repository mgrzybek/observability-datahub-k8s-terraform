resource "kubernetes_manifest" "subscription_strimzi_kafka_operator" {
  provisioner "local-exec" {
    command = join(" ", [
      "kubectl wait",
      "operator/strimzi-kafka-operator.%{if var.isOpenshift}openshift-%{endif}operators",
      "--for=condition=Ready --timeout=600s"
    ])
  }

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

