module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 19.0"

  cluster_name = var.cluster_name

  # 👇 ¡ESTO ES LO QUE TE SALVA LA BILLETERA! 👇
  cluster_version = "1.31"
  # 👆 Forzamos la versión 1.31 (Estándar, $0.10/hora)

  # 🌐 RED: Cluster público
  cluster_endpoint_public_access = true

  vpc_id                   = var.vpc_id
  subnet_ids               = var.subnet_ids
  control_plane_subnet_ids = var.subnet_ids

  # 🛡️ SEGURIDAD
  enable_irsa = true

  # 💰 NODOS (WORKERS)
  eks_managed_node_groups = {
    spot_nodes_v2 = {
      min_size     = var.min_size
      max_size     = var.max_size
      desired_size = var.desired_size

      instance_types = var.node_instance_types
      capacity_type  = "ON_DEMAND"

      associate_public_ip_address = true

      labels = {
        Environment = var.environment
        NodeType    = "spot"
      }
    }
  }

  tags = {
    Environment = var.environment
    Terraform   = "true"
    Project     = "GpuChile"
  }
}