variable "environment" {
  description = "Entorno de despliegue"
  type        = string
}

variable "vpc_id" {
  description = "ID de la VPC"
  type        = string
}

variable "subnet_ids" {
  description = "Lista de subnet IDs para el subnet group"
  type        = list(string)
}

variable "allowed_security_group_id" {
  description = "Security Group ID del EKS cluster para permitir conexión"
  type        = string
}

variable "db_name" {
  description = "Nombre de la base de datos"
  type        = string
  default     = "gpuchile"
}

variable "db_username" {
  description = "Usuario maestro de la DB"
  type        = string
  default     = "gpuchile_admin"
}

variable "instance_class" {
  description = "Tipo de instancia RDS"
  type        = string
  default     = "db.t3.micro" # Free Tier eligible (750 horas/mes)
}

variable "allocated_storage" {
  description = "Almacenamiento en GB"
  type        = number
  default     = 20
}
