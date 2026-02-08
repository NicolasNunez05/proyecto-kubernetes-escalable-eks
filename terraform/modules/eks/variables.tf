variable "cluster_name" {
  description = "Nombre del cluster EKS"
  type        = string
}

variable "vpc_id" {
  description = "ID de la VPC donde se desplegará el cluster"
  type        = string
}

variable "subnet_ids" {
  description = "Lista de IDs de subnets para los nodos y el control plane"
  type        = list(string)
}

variable "environment" {
  description = "Entorno (dev, prod, etc.)"
  type        = string
  default     = "dev"
}

variable "cluster_version" {
  description = "Versión de Kubernetes"
  type        = string
  default     = "1.29"
}

variable "node_instance_types" {
  description = "Tipos de instancia para los nodos trabajadores"
  type        = list(string)
  default     = ["t3.medium"]
}

variable "min_size" {
  description = "Número mínimo de nodos"
  type        = number
  default     = 1
}

variable "max_size" {
  description = "Número máximo de nodos"
  type        = number
  default     = 2
}

variable "desired_size" {
  description = "Número deseado de nodos iniciales"
  type        = number
  default     = 1
}
