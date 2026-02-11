# terraform/outputs.tf

# VPC Outputs
output "vpc_id" {
  description = "ID de la VPC"
  value       = module.vpc.vpc_id
}

# EKS Outputs
output "eks_cluster_name" {
  description = "Nombre del cluster EKS"
  value       = module.eks.cluster_name
}

output "eks_cluster_endpoint" {
  description = "Endpoint del cluster EKS"
  value       = module.eks.cluster_endpoint
}

output "eks_cluster_security_group_id" {
  description = "Security Group del cluster"
  value       = module.eks.cluster_security_group_id
}

output "configure_kubectl" {
  description = "Comando para configurar kubectl"
  value       = "aws eks update-kubeconfig --name ${module.eks.cluster_name} --region ${var.region}"
}

# RDS Outputs
output "rds_endpoint" {
  description = "Endpoint de la base de datos RDS"
  value       = module.rds.db_instance_endpoint
  sensitive   = true
}

output "rds_secret_arn" {
  description = "ARN del secreto de RDS en Secrets Manager"
  value       = module.rds.db_secret_arn
}

# S3 Outputs
output "s3_bucket_name" {
  description = "Nombre del bucket S3"
  value       = module.s3.bucket_name
}

output "s3_bucket_arn" {
  description = "ARN del bucket S3"
  value       = module.s3.bucket_arn
}

# Lambda Outputs
output "lambda_function_name" {
  description = "Nombre de la función Lambda"
  value       = module.lambda.lambda_function_name
}

# Secrets Outputs
output "jwt_secret_arn" {
  description = "ARN del secreto JWT"
  value       = module.secrets.jwt_secret_arn
}

output "redis_secret_arn" {
  description = "ARN del secreto Redis"
  value       = module.secrets.redis_secret_arn
}

# IRSA Outputs
output "backend_service_account_role_arn" {
  description = "ARN del IAM Role para el backend"
  value       = module.backend_irsa.role_arn
}

# Monitoring Outputs (Iter 4)
output "grafana_access" {
  description = "Cómo acceder a Grafana"
  value       = module.monitoring.grafana_access_command
}

output "grafana_credentials" {
  description = "Credenciales de Grafana"
  value       = module.monitoring.grafana_credentials
}

output "prometheus_role_arn" {
  description = "IAM Role ARN para Prometheus"
  value       = module.monitoring.prometheus_role_arn
}

# Autoscaling Outputs (Iter 5)
output "cluster_autoscaler_role_arn" {
  description = "IAM Role ARN para Cluster Autoscaler"
  value       = module.autoscaling.cluster_autoscaler_role_arn
}

# Logging Outputs (Iter 7)
output "fluent_bit_role_arn" {
  description = "IAM Role ARN para Fluent Bit"
  value       = module.logging.fluent_bit_role_arn
}

output "log_group_name" {
  description = "CloudWatch Log Group para logs de aplicación"
  value       = module.logging.log_group_name
}

output "view_logs_command" {
  description = "Comando para ver logs en tiempo real"
  value       = module.logging.view_logs_command
}

# Comandos útiles
output "useful_commands" {
  description = "Comandos útiles para gestionar el cluster"
  value = {
    configure_kubectl = "aws eks update-kubeconfig --name ${module.eks.cluster_name} --region ${var.region}"
    get_nodes         = "kubectl get nodes"
    get_pods          = "kubectl get pods -A"
    access_grafana    = module.monitoring.grafana_access_command
    view_logs         = module.logging.view_logs_command
  }
}


