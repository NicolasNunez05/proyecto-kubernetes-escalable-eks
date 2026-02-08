output "prometheus_role_arn" {
  description = "ARN del IAM Role para Prometheus"
  value       = aws_iam_role.prometheus.arn
}

output "namespace" {
  value = var.namespace
}
