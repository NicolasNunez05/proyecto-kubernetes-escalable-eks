output "backend_service_account_role_arn" {
  description = "ARN del IAM role para el backend service account"
  value       = aws_iam_role.backend_service_account.arn
}

output "cluster_autoscaler_role_arn" {
  description = "ARN del IAM role para Cluster Autoscaler"
  value       = aws_iam_role.cluster_autoscaler.arn
}

output "prometheus_role_arn" {
  description = "ARN del IAM role para Prometheus"
  value       = aws_iam_role.prometheus.arn
}

output "fluent_bit_role_arn" {
  description = "ARN del IAM role para Fluent Bit"
  value       = aws_iam_role.fluent_bit.arn
}
