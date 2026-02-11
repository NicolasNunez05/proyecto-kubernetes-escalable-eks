output "cluster_autoscaler_role_arn" {
  description = "ARN del IAM Role para Cluster Autoscaler"
  value       = aws_iam_role.cluster_autoscaler.arn
}
