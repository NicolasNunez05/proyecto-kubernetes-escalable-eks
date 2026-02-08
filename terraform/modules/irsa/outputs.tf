output "role_arn" {
  description = "ARN del IAM Role para el Service Account"
  value       = aws_iam_role.service_account.arn
}

output "role_name" {
  description = "Nombre del IAM Role"
  value       = aws_iam_role.service_account.name
}
