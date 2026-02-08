# Generar password aleatorio (se guarda en Terraform State)
resource "random_password" "db_password" {
  length  = 24
  special = true
}

# Security Group para RDS
resource "aws_security_group" "rds" {
  name        = "gpuchile-rds-${var.environment}"
  description = "Security group for RDS PostgreSQL"
  vpc_id      = var.vpc_id

  ingress {
    description     = "PostgreSQL from EKS"
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [var.allowed_security_group_id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "gpuchile-rds-sg"
    Environment = var.environment
  }
}

# Subnet Group (RDS necesita al menos 2 AZs)
resource "aws_db_subnet_group" "main" {
  name       = "gpuchile-db-subnet-${var.environment}"
  subnet_ids = var.subnet_ids

  tags = {
    Name = "GpuChile DB Subnet Group"
  }
}

# RDS Instance
resource "aws_db_instance" "postgres" {
  identifier     = "gpuchile-db-${var.environment}"
  engine         = "postgres"
  engine_version = "16.3"
  instance_class = var.instance_class

  allocated_storage     = var.allocated_storage
  max_allocated_storage = 50 # Autoscaling hasta 50GB

  db_name  = var.db_name
  username = var.db_username
  password = random_password.db_password.result

  db_subnet_group_name   = aws_db_subnet_group.main.name
  vpc_security_group_ids = [aws_security_group.rds.id]

  # ⚠️ COST SAVING: Single-AZ (Multi-AZ duplica el costo)
  multi_az                = false
  publicly_accessible     = false
  skip_final_snapshot     = true # Para dev/portfolio (En prod: false)
  backup_retention_period = 7

  tags = {
    Name        = "gpuchile-postgres"
    Environment = var.environment
  }
}

# Guardar credenciales en AWS Secrets Manager (para External Secrets Operator)
resource "aws_secretsmanager_secret" "db_credentials" {
  name = "gpuchile/${var.environment}/db"

  tags = {
    Environment = var.environment
  }
}

resource "aws_secretsmanager_secret_version" "db_credentials" {
  secret_id = aws_secretsmanager_secret.db_credentials.id
  secret_string = jsonencode({
    username = aws_db_instance.postgres.username
    password = random_password.db_password.result
    host     = aws_db_instance.postgres.address
    port     = aws_db_instance.postgres.port
    dbname   = aws_db_instance.postgres.db_name
    url      = "postgresql://${aws_db_instance.postgres.username}:${random_password.db_password.result}@${aws_db_instance.postgres.address}:${aws_db_instance.postgres.port}/${aws_db_instance.postgres.db_name}"
  })
}
