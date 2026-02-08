variable "environment" {
  description = "Entorno de despliegue"
  type        = string
}

variable "s3_bucket_name" {
  description = "Nombre del bucket S3 que disparará la Lambda"
  type        = string
}

variable "s3_bucket_arn" {
  description = "ARN del bucket S3"
  type        = string
}

variable "function_name" {
  description = "Nombre de la función Lambda"
  type        = string
  default     = "gpuchile-image-resizer"
}
