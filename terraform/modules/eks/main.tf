module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 19.21"

  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version

  # Network
  vpc_id     = var.vpc_id
  subnet_ids = var.private_subnet_ids

  # Public API endpoint
  cluster_endpoint_public_access = true

  # Private access necesario para que nodos se conecten
  cluster_endpoint_private_access = true

  # OIDC Provider (necesario para IRSA)
  enable_irsa = true

  # ====================================================
  # ✅ NUEVO: INSTALACIÓN AUTOMÁTICA DEL DRIVER DE EBS
  # ====================================================
  cluster_addons = {
    aws-ebs-csi-driver = {
      most_recent = true
    }
  }

  # Node Groups
  eks_managed_node_groups = {
    for name, config in var.node_groups : name => {
      min_size       = config.min_size
      max_size       = config.max_size
      desired_size   = config.desired_size
      instance_types = config.instance_types
      capacity_type  = "ON_DEMAND"

      # Usar subnets privadas explícitamente
      subnet_ids = var.private_subnet_ids

      # ====================================================
      # ✅ NUEVO: PERMISOS IAM PARA QUE EL NODO CREE DISCOS
      # ====================================================
      iam_role_additional_policies = {
        AmazonEBSCSIDriverPolicy = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
      }

      labels = {
        Environment = var.tags["Environment"]
        NodeType    = "on-demand"
      }

      tags = merge(
        var.tags,
        {
          Name = "${var.cluster_name}-${name}"
        }
      )
    }
  }

  # Cluster security group - SOLO reglas adicionales que NO crea el módulo
  cluster_security_group_additional_rules = {
    ingress_nodes_ephemeral_ports_tcp = {
      description                = "Nodes on ephemeral ports"
      protocol                   = "tcp"
      from_port                  = 1025
      to_port                    = 65535
      type                       = "ingress"
      source_node_security_group = true
    }
  }

  # Node security group
  node_security_group_additional_rules = {
    ingress_self_all = {
      description = "Node to node all ports/protocols"
      protocol    = "-1"
      from_port   = 0
      to_port     = 0
      type        = "ingress"
      self        = true
    }
    
    ingress_cluster_all = {
      description                   = "Cluster to node all ports/protocols"
      protocol                      = "-1"
      from_port                     = 0
      to_port                       = 0
      type                          = "ingress"
      source_cluster_security_group = true
    }

    egress_all = {
      description      = "Node all egress"
      protocol         = "-1"
      from_port        = 0
      to_port          = 0
      type             = "egress"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    }
  }

  tags = var.tags
}