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
  name      = "techlogs"
}

module "auditlogs" {
  depends_on = [kubernetes_namespace.logs]
  source     = "git::https://github.com/mgrzybek/terraform-module-k8s-bucket-claim"

  namespace = var.namespace
  name      = "auditlogs"
}

module "logs" {
  depends_on = [kubernetes_namespace.logs]
  source     = "git::https://github.com/mgrzybek/terraform-module-k8s-bucket-claim"

  namespace = var.namespace
  name      = "logs"
}

