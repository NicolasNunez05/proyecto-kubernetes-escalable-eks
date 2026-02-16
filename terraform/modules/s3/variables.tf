variable "bucket_name" {
  description = "Nombre del bucket S3 (debe ser globalmente único)"
  type        = string
}

variable "environment" {
  description = "Environment (dev, prod)"
  type        = string
}
