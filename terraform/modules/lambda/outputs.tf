output "function_name" {
  description = "Nombre de la función Lambda"
  value       = aws_lambda_function.resizer.function_name
}

output "function_arn" {
  description = "ARN de la función Lambda"
  value       = aws_lambda_function.resizer.arn
}

output "role_arn" {
  description = "ARN del IAM role de Lambda"
  value       = aws_iam_role.lambda.arn
}
