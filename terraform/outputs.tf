# terraform/outputs.tf

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "eks_cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

output "eks_cluster_name" {
  value = module.eks.cluster_name
}

output "rds_endpoint" {
  value = module.rds.db_instance_endpoint
}

output "s3_bucket_name" {
  value = module.s3.bucket_name
}

output "lambda_function_name" {
  value = module.lambda.lambda_function_name
}

output "backend_service_account_role_arn" {
  description = "ARN del IAM Role para el backend Service Account"
  value       = module.backend_irsa.role_arn
}

output "jwt_secret_arn" {
  value = module.secrets.jwt_secret_arn
}

#output "ecr_repositories" {
#  description = "URLs de los repositorios ECR"
#  value       = module.ecr.repository_urls
#}

#output "prometheus_role_arn" {
 # value = module.monitoring.prometheus_role_arn
#}
