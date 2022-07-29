output "configmap" {
  depends_on = [data.kubernetes_config_map.configmap]

  value = data.kubernetes_config_map.configmap
}

output "secret" {
  depends_on = [data.kubernetes_secret.secret]
  sensitive  = true

  value = data.kubernetes_secret.secret
}
