variable "cluster_name" {
  description = "Nombre del cluster EKS"
  type        = string
}

variable "oidc_provider_arn" {
  description = "ARN del OIDC provider del cluster EKS"
  type        = string
}

variable "namespace" {
  description = "Namespace de Kubernetes donde correrá la app"
  type        = string
  default     = "default"
}

variable "service_account_name" {
  description = "Nombre del Service Account en K8s"
  type        = string
}

variable "s3_bucket_arn" {
  description = "ARN del bucket S3 para permisos"
  type        = string
}

variable "secrets_arns" {
  description = "Lista de ARNs de secretos en Secrets Manager"
  type        = list(string)
}
