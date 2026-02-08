output "jwt_secret_arn" {
  description = "ARN del secreto JWT"
  value       = aws_secretsmanager_secret.jwt.arn
}

output "redis_secret_arn" {
  description = "ARN del secreto Redis"
  value       = aws_secretsmanager_secret.redis.arn
}
