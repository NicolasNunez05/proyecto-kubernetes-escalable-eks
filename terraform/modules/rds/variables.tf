variable "project_name" {
  description = "Nombre del proyecto"
  type        = string
}

variable "environment" {
  description = "Entorno (dev, prod)"
  type        = string
}

variable "vpc_id" {
  description = "ID de la VPC"
  type        = string
}

variable "subnet_ids" {
  description = "IDs de las subnets para el subnet group"
  type        = list(string)
}

variable "db_name" {
  description = "Nombre de la base de datos"
  type        = string
  default     = "gpuchile"
}

# ✅ YA ESTÁ CORRECTO: gpuchileadmin (no "admin")
variable "db_username" {
  description = "Usuario de la base de datos"
  type        = string
  default     = "gpuchileadmin"
}

variable "instance_class" {
  description = "Clase de instancia RDS"
  type        = string
  default     = "db.t3.micro"
}

variable "allocated_storage" {
  description = "Almacenamiento asignado en GB"
  type        = number
  default     = 20
}

variable "allowed_security_group_id" {
  description = "Security Group ID del EKS cluster para permitir conexión"
  type        = string
}
