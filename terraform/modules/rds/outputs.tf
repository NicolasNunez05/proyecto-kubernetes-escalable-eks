output "db_instance_endpoint" {
  description = "El endpoint de conexión de la base de datos"
  value       = aws_db_instance.postgres.endpoint
}

output "db_instance_name" {
  description = "El nombre de la base de datos"
  value       = aws_db_instance.postgres.db_name
}

output "db_secret_arn" {
  description = "ARN del secreto en Secrets Manager"
  value       = aws_secretsmanager_secret.db_credentials.arn
}

output "db_security_group_id" {
  description = "ID del security group de RDS"
  value       = aws_security_group.rds.id
}
