module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.1"

  name = "${var.project_name}-vpc-${var.environment}"
  cidr = var.vpc_cidr

  azs             = var.availability_zones
  private_subnets = var.private_subnet_cidrs
  public_subnets  = var.public_subnet_cidrs

  # NAT Gateway (1 compartido para ahorrar costos)
  enable_nat_gateway = true
  single_nat_gateway = true   # ← CAMBIÓ: false → true
  enable_vpn_gateway = false  # ← CAMBIÓ: true → false

  # DNS necesario para EKS
  enable_dns_hostnames = true
  enable_dns_support   = true

  # Tags requeridos por EKS y AWS Load Balancer Controller
  public_subnet_tags = {
    "kubernetes.io/role/elb"                    = "1"
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
  }

  private_subnet_tags = {
    "kubernetes.io/role/internal-elb"           = "1"
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
  }

  tags = {
    Name        = "${var.project_name}-vpc-${var.environment}"
    Environment = var.environment
    Terraform   = "true"
    Project     = var.project_name
  }
}
