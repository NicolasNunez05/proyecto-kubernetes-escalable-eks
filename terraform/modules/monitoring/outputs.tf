output "prometheus_role_arn" {
  description = "ARN del IAM Role para Prometheus"
  value       = aws_iam_role.prometheus.arn
}

output "grafana_access_command" {
  description = "Comando para acceder a Grafana"
  # Nota: El chart suele nombrar al servicio como "RELEASE-grafana"
  value       = "kubectl port-forward -n ${var.namespace} svc/prometheus-stack-grafana 3000:80"
}

output "grafana_credentials" {
  description = "Credenciales de Grafana"
  value = {
    username = "admin"
    password = "admin"
    url      = "http://localhost:3000"
  }
  sensitive = false
}