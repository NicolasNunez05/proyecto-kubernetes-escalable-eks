variable "project_name" {
  description = "Nombre del proyecto"
  type        = string
}

variable "environment" {
  description = "Entorno (dev, prod)"
  type        = string
}

variable "cluster_name" {
  description = "Nombre del cluster EKS"
  type        = string
}

variable "oidc_provider_arn" {
  description = "ARN del OIDC provider del cluster EKS"
  type        = string
}

variable "s3_bucket_arn" {
  description = "ARN del bucket S3"
  type        = string
}

variable "secrets_arns" {
  description = "Lista de ARNs de secretos en Secrets Manager"
  type        = list(string)
}
