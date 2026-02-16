output "endpoint" {
  description = "Endpoint de conexión de RDS"
  value       = aws_db_instance.postgres.endpoint
  sensitive   = true
}

output "address" {
  description = "Address (hostname) de RDS"
  value       = aws_db_instance.postgres.address
}

output "port" {
  description = "Puerto de RDS"
  value       = aws_db_instance.postgres.port
}

output "db_name" {
  description = "Nombre de la base de datos"
  value       = aws_db_instance.postgres.db_name
}

output "secret_arn" {
  description = "ARN del secreto en Secrets Manager"
  value       = aws_secretsmanager_secret.db_credentials.arn
}

output "security_group_id" {
  description = "Security group ID de RDS"
  value       = aws_security_group.rds.id
}
