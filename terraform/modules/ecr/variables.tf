variable "environment" {
  description = "Entorno de despliegue"
  type        = string
}

variable "repositories" {
  description = "Lista de nombres de repositorios ECR"
  type        = list(string)
  default     = ["gpuchile-backend", "gpuchile-frontend"]
}
