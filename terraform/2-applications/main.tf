# ============================================
# APPLICATIONS PHASE
# Despliega: Helm charts, K8s manifests
# ============================================

module "helm_controllers" {
  source = "../modules/helm-controllers"

  cluster_name      = local.cluster_name
  aws_region        = data.terraform_remote_state.infrastructure.outputs.aws_region
  vpc_id            = data.terraform_remote_state.infrastructure.outputs.vpc_id
  oidc_provider_arn = local.oidc_provider_arn
  
  # IAM Roles
  cluster_autoscaler_role_arn = local.cluster_autoscaler_role
  prometheus_role_arn         = local.prometheus_role_arn
  fluent_bit_role_arn         = local.fluent_bit_role_arn
  
  # External Secrets
  enable_external_secrets = false
  secrets_to_sync = {
    rds = {
      secret_arn = local.rds_secret_arn
      keys       = ["username", "password", "host", "port", "dbname"]
    }
    redis = {
      secret_arn = local.redis_secret_arn
      keys       = ["endpoint", "port"]
    }
  }
  
  # Monitoring
  enable_prometheus      = true
  enable_grafana         = true
  grafana_admin_password = var.grafana_password
  
  # Logging
  enable_fluent_bit = true
  log_group_name    = "/aws/eks/${local.cluster_name}/application"
  
  # Autoscaling
  enable_cluster_autoscaler = true
  enable_metrics_server     = true

  tags = {
    Environment = data.terraform_remote_state.infrastructure.outputs.environment
    Project     = "gpuchile"
  }
}

