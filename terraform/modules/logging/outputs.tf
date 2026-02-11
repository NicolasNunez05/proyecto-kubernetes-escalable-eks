output "fluent_bit_role_arn" {
  description = "ARN del IAM Role para Fluent Bit"
  value       = aws_iam_role.fluent_bit.arn
}

output "log_group_name" {
  description = "Nombre del CloudWatch Log Group"
  value       = aws_cloudwatch_log_group.eks_logs.name
}

output "namespace" {
  description = "Namespace donde se instaló Fluent Bit"
  value       = "logging"
}

output "view_logs_command" {
  description = "Comando para ver logs en CloudWatch"
  value       = "aws logs tail ${aws_cloudwatch_log_group.eks_logs.name} --follow"
}
