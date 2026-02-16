# ============================================
# OUTPUTS - INFRASTRUCTURE PHASE
# Estos valores se importan en la fase 2
# ============================================

output "vpc_id" {
  description = "VPC ID"
  value       = module.vpc.vpc_id
}

output "private_subnet_ids" {
  description = "Private subnet IDs"
  value       = module.vpc.private_subnet_ids
}

# EKS Cluster
output "cluster_name" {
  description = "EKS cluster name"
  value       = module.eks.cluster_name
}

output "cluster_endpoint" {
  description = "EKS cluster endpoint"
  value       = module.eks.cluster_endpoint
}

output "cluster_certificate_authority_data" {
  description = "EKS cluster CA certificate"
  value       = module.eks.cluster_certificate_authority_data
  sensitive   = true
}

output "cluster_security_group_id" {
  description = "EKS cluster security group ID"
  value       = module.eks.cluster_security_group_id
}

output "oidc_provider_arn" {
  description = "OIDC provider ARN for IRSA"
  value       = module.eks.oidc_provider_arn
}

# Database
output "rds_endpoint" {
  description = "RDS endpoint"
  value       = module.rds.endpoint
  sensitive   = true
}

output "rds_secret_arn" {
  description = "RDS credentials secret ARN"
  value       = module.rds.secret_arn
}

# Redis
output "redis_endpoint" {
  description = "Redis endpoint"
  value       = module.redis.endpoint
  sensitive   = true
}

output "redis_secret_arn" {
  description = "Redis credentials secret ARN"
  value       = module.redis.secret_arn
}

# S3
output "s3_bucket_name" {
  description = "S3 bucket name"
  value       = module.s3.bucket_name
}

output "s3_bucket_arn" {
  description = "S3 bucket ARN"
  value       = module.s3.bucket_arn
}

# IAM Roles
output "backend_service_account_role_arn" {
  description = "Backend service account IAM role ARN"
  value       = module.iam.backend_service_account_role_arn
}

output "cluster_autoscaler_role_arn" {
  description = "Cluster autoscaler IAM role ARN"
  value       = module.iam.cluster_autoscaler_role_arn
}

output "prometheus_role_arn" {
  description = "Prometheus IAM role ARN"
  value       = module.iam.prometheus_role_arn
}

output "fluent_bit_role_arn" {
  description = "Fluent Bit IAM role ARN"
  value       = module.iam.fluent_bit_role_arn
}

# Lambda
output "lambda_function_name" {
  description = "Lambda function name"
  value       = module.lambda.function_name
}

# Configuración
output "aws_region" {
  description = "AWS region"
  value       = var.aws_region
}

output "environment" {
  description = "Environment name"
  value       = var.environment
}

output "configure_kubectl" {
  description = "Command to configure kubectl"
  value       = "aws eks update-kubeconfig --name ${module.eks.cluster_name} --region ${var.aws_region}"
}
