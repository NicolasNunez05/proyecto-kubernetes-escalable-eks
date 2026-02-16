variable "project_name" {
  description = "Nombre del proyecto"
  type        = string
}

variable "environment" {
  description = "Entorno (dev, prod)"
  type        = string
}

variable "repositories" {
  description = "Lista de nombres de repositorios ECR a crear"
  type        = list(string)
  default     = ["backend", "frontend"]
}
