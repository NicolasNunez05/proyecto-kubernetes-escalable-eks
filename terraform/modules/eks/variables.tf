variable "cluster_name" {
  description = "Nombre del cluster EKS"
  type        = string
}

variable "cluster_version" {
  description = "Versión de Kubernetes"
  type        = string
}

variable "vpc_id" {
  description = "ID de la VPC"
  type        = string
}

variable "private_subnet_ids" {
  description = "IDs de las subnets privadas"
  type        = list(string)
}

# ✅ CAMBIO AQUÍ: Tipos de instancia optimizados
variable "node_groups" {
  description = "Configuración de node groups"
  type = map(object({
    min_size       = number
    max_size       = number
    desired_size   = number
    instance_types = list(string)
  }))
  
  # ✅ VALORES POR DEFAULT OPTIMIZADOS
  default = {
    general = {
      min_size       = 2                                        # ← Cambió de 1 a 2
      max_size       = 3                                        # ← Cambió de 2 a 3
      desired_size   = 2                                        # ← Cambió de 1 a 2
      instance_types = ["t3a.small", "t3.small", "t2.small"]  # ← Cambió de ["t3.medium"]
    }
  }
}

variable "tags" {
  description = "Tags para recursos"
  type        = map(string)
  default     = {}
}
