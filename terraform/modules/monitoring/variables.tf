variable "cluster_name" {
  description = "Nombre del cluster EKS"
  type        = string
}

variable "oidc_provider_arn" {
  description = "ARN del OIDC provider"
  type        = string
}

variable "namespace" {
  description = "Namespace para Prometheus"
  type        = string
  default     = "monitoring"
}
