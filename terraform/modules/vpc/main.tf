module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.1.2"

  name = "gpuchile-vpc-${var.environment}"
  cidr = var.vpc_cidr

  azs             = var.availability_zones
  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets

  # ⚠️ COST SAVING: NAT Gateway desactivado ($32/mes ahorro)
  enable_nat_gateway = false
  single_nat_gateway = false
  enable_vpn_gateway = false

  # Requisitos EKS
  enable_dns_hostnames = true
  enable_dns_support   = true

  # ⚠️ CRÍTICO: IP pública automática para nodos (ya que no hay NAT)
  map_public_ip_on_launch = true

  # Tags requeridos por AWS Load Balancer Controller
  public_subnet_tags = {
    "kubernetes.io/role/elb"                    = 1
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
  }

  private_subnet_tags = {
    "kubernetes.io/role/internal-elb"           = 1
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
  }

  tags = {
    Environment = var.environment
    Terraform   = "true"
    Project     = "GpuChile"
  }
}
