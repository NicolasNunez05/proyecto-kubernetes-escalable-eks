# Importar el estado de la Fase 1 desde S3
data "terraform_remote_state" "infrastructure" {
  backend = "s3"
  config = {
    bucket = "gpuchile-tfstate-592451843842-20260210" # TU BUCKET
    key    = "infrastructure/terraform.tfstate"      # La key de la Fase 1
    region = "us-east-1"
  }
}

# (El resto del archivo data.tf sigue igual con los locals...)
locals {
  cluster_name      = data.terraform_remote_state.infrastructure.outputs.cluster_name
  oidc_provider_arn = data.terraform_remote_state.infrastructure.outputs.oidc_provider_arn
  
  # IAM Roles
  backend_role_arn        = data.terraform_remote_state.infrastructure.outputs.backend_service_account_role_arn
  cluster_autoscaler_role = data.terraform_remote_state.infrastructure.outputs.cluster_autoscaler_role_arn
  prometheus_role_arn     = data.terraform_remote_state.infrastructure.outputs.prometheus_role_arn
  fluent_bit_role_arn     = data.terraform_remote_state.infrastructure.outputs.fluent_bit_role_arn
  
  # Secrets
  rds_secret_arn   = data.terraform_remote_state.infrastructure.outputs.rds_secret_arn
  redis_secret_arn = data.terraform_remote_state.infrastructure.outputs.redis_secret_arn
}