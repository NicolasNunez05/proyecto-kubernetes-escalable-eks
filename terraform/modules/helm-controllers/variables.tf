variable "cluster_name" {
  description = "Nombre del cluster EKS"
  type        = string
}

variable "aws_region" {
  description = "Región de AWS"
  type        = string
}

variable "vpc_id" {
  description = "ID de la VPC"
  type        = string
}

variable "oidc_provider_arn" {
  description = "ARN del OIDC provider del cluster"
  type        = string
}

variable "tags" {
  description = "Tags para recursos"
  type        = map(string)
  default     = {}
}

# Roles IAM
variable "cluster_autoscaler_role_arn" {
  description = "ARN del IAM role para Cluster Autoscaler"
  type        = string
}

variable "prometheus_role_arn" {
  description = "ARN del IAM role para Prometheus"
  type        = string
}

variable "fluent_bit_role_arn" {
  description = "ARN del IAM role para Fluent Bit"
  type        = string
}

# External Secrets
variable "enable_external_secrets" {
  description = "Habilitar External Secrets Operator"
  type        = bool
  default     = true
}

variable "secrets_to_sync" {
  description = "Secretos de AWS Secrets Manager para sincronizar"
  type = map(object({
    secret_arn = string
    keys       = list(string)
  }))
  default = {}
}

# Monitoring
variable "enable_prometheus" {
  description = "Habilitar Prometheus"
  type        = bool
  default     = true
}

variable "enable_grafana" {
  description = "Habilitar Grafana"
  type        = bool
  default     = true
}

variable "grafana_admin_password" {
  description = "Contraseña de admin de Grafana"
  type        = string
  default     = "admin123"
  sensitive   = true
}

# Logging
variable "enable_fluent_bit" {
  description = "Habilitar Fluent Bit para logs"
  type        = bool
  default     = true
}

variable "log_group_name" {
  description = "Nombre del CloudWatch Log Group"
  type        = string
  default     = "/aws/eks/cluster/application"
}

# Autoscaling
variable "enable_cluster_autoscaler" {
  description = "Habilitar Cluster Autoscaler"
  type        = bool
  default     = true
}

variable "enable_metrics_server" {
  description = "Habilitar Metrics Server"
  type        = bool
  default     = true
}
