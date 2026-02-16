output "metrics_server_installed" {
  description = "¿Metrics Server está instalado?"
  value       = var.enable_metrics_server
}

output "prometheus_installed" {
  description = "¿Prometheus está instalado?"
  value       = var.enable_prometheus
}

output "grafana_installed" {
  description = "¿Grafana está instalado?"
  value       = var.enable_grafana
}

output "external_secrets_installed" {
  description = "¿External Secrets está instalado?"
  value       = var.enable_external_secrets
}

output "cluster_autoscaler_installed" {
  description = "¿Cluster Autoscaler está instalado?"
  value       = var.enable_cluster_autoscaler
}

output "fluent_bit_installed" {
  description = "¿Fluent Bit está instalado?"
  value       = var.enable_fluent_bit
}
