module "techlogs" {
  source    = "git::https://github.com/mgrzybek/terraform-module-k8s-bucket-claim"

  namespace = var.namespace
  name      = "techlogs"
}

module "auditlogs" {
  source    = "git::https://github.com/mgrzybek/terraform-module-k8s-bucket-claim"

  namespace = var.namespace
  name      = "auditlogs"
}

module "logs" {
  source    = "git::https://github.com/mgrzybek/terraform-module-k8s-bucket-claim"

  namespace = var.namespace
  name      = "logs"
}
