# Generar JWT Secret aleatorio
resource "random_password" "jwt_secret" {
  length  = 64
  special = true
}

# Secreto para JWT
resource "aws_secretsmanager_secret" "jwt" {
  name = "gpuchile/${var.environment}/jwt"

  tags = {
    Environment = var.environment
  }
}

resource "aws_secretsmanager_secret_version" "jwt" {
  secret_id = aws_secretsmanager_secret.jwt.id
  secret_string = jsonencode({
    secret = random_password.jwt_secret.result
  })
}

# Secreto para Redis (si lo usas en K8s como pod)
resource "aws_secretsmanager_secret" "redis" {
  name = "gpuchile/${var.environment}/redis"

  tags = {
    Environment = var.environment
  }
}

resource "aws_secretsmanager_secret_version" "redis" {
  secret_id = aws_secretsmanager_secret.redis.id
  secret_string = jsonencode({
    url = "redis://redis-service.default.svc.cluster.local:6379/0"
  })
}
