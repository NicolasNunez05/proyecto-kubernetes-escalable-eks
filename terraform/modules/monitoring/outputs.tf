output "prometheus_role_arn" {
  description = "ARN del IAM Role para Prometheus"
  value       = aws_iam_role.prometheus.arn
}

output "namespace" {
  value = var.namespace
}

output "grafana_access_command" {
  description = "Comando para acceder a Grafana desde tu PC"
  value       = "kubectl port-forward -n ${var.namespace} svc/prometheus-stack-grafana 3000:80"
}

output "grafana_credentials" {
  description = "Credenciales de Grafana"
  value = {
    username = "admin"
    password = "admin123"
    url      = "http://localhost:3000 (después de ejecutar el comando de port-forward)"
  }
  sensitive = false  # Para que se muestre en terraform output
}
