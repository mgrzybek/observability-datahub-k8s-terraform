resource "kubernetes_manifest" "bucket" {
  manifest = {
    "apiVersion" = "objectbucket.io/v1alpha1"
    "kind"       = "ObjectBucketClaim"
    "metadata" = {
      "name"      = var.name
      "namespace" = var.namespace
    }
    "spec" = {
      "generateBucketName" = var.name
      "storageClassName"   = "openshift-storage.noobaa.io"
    }
  }
}

data "kubernetes_config_map" "configmap" {
  metadata {
    name      = var.name
    namespace = var.namespace
  }
}

data "kubernetes_secret" "secret" {
  metadata {
    name      = var.name
    namespace = var.namespace
  }
}
