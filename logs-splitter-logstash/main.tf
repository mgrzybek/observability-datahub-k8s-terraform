resource "kubernetes_config_map" "configmap" {
  metadata {
    name      = "${var.name}-logstash-configmap"
    namespace = var.namespace
  }

  data = {
    logstash_conf = templatefile(
      "${path.module}/logstash.tmpl.conf",
      {
        source_topics           = var.source_topics
        destination_tech_topic  = var.destination_tech_topic
        destination_audit_topic = var.destination_audit_topic
        bootstrap_servers       = var.bootstrap_servers
        log_key                 = var.log_key
        log_value               = var.log_value
        nested_log_key          = var.nested_log_key
        nested_log_value        = var.nested_log_value
      }
    )
    logstash_yml = <<-EOT
    http.host: "0.0.0.0"
    path.config: /usr/share/logstash/pipeline

    EOT
  }
}

resource "kubernetes_deployment" "logstash" {
  depends_on = [kubernetes_config_map.configmap]

  metadata {
    name      = var.name
    namespace = var.namespace
  }

  spec {
    replicas = var.number
    selector {
      match_labels = {
        app = var.name
      }
    }

    template {
      metadata {
        labels = {
          app = var.name
        }
      }

      spec {
        container {
          image = "docker.elastic.co/logstash/logstash-oss:7.7.1"
          name  = var.name

          resources {
            limits = {
              cpu    = "1000m"
              memory = "2Gi"
            }
            requests = {
              cpu    = "800m"
              memory = "1Gi"
            }
          }

          volume_mount {
            mount_path = "/usr/share/logstash/config"
            name       = "${var.name}-config-volume"
          }

          volume_mount {
            mount_path = "/usr/share/logstash/pipeline"
            name       = "${var.name}-pipeline-volume"
          }
        }

        volume {
          name = "${var.name}-config-volume"

          config_map {
            name = "${var.name}-logstash-configmap"
            items {
              key  = "logstash_yml"
              path = "logstash.yml"
            }
          }
        }

        volume {
          name = "${var.name}-pipeline-volume"

          config_map {
            name = "${var.name}-logstash-configmap"

            items {
              key  = "logstash_conf"
              path = "logstash.conf"
            }
          }
        }
      }
    }
  }
}
