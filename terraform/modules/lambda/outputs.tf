output "lambda_function_arn" {
  description = "ARN de la función Lambda"
  value       = aws_lambda_function.resizer.arn
}

output "lambda_function_name" {
  description = "Nombre de la función Lambda"
  value       = aws_lambda_function.resizer.function_name
}
