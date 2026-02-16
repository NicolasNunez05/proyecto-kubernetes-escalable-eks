# ============================================
# INFRASTRUCTURE PHASE
# Crea: VPC, EKS, RDS, Redis, S3, ECR, IAM, Lambda
# ============================================

locals {
  cluster_name = "${var.project_name}-cluster"
  common_tags = {
    Environment = var.environment
    Project     = var.project_name
  }
}


# VPC
module "vpc" {
  source = "../modules/vpc"

  project_name         = var.project_name
  environment          = var.environment
  vpc_cidr             = var.vpc_cidr
  availability_zones   = var.availability_zones
  private_subnet_cidrs = var.private_subnet_cidrs
  public_subnet_cidrs  = var.public_subnet_cidrs
  cluster_name         = local.cluster_name  # ← AGREGAR ESTA LÍNEA
}

# EKS Cluster
module "eks" {
  source = "../modules/eks"

  cluster_name       = local.cluster_name
  cluster_version    = var.cluster_version
  vpc_id             = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnet_ids
  
  node_groups = {
    general = {
      desired_size = var.node_desired_size
      min_size     = var.node_min_size
      max_size     = var.node_max_size
      instance_types = var.node_instance_types
    }
  }

  tags = local.common_tags
}

# RDS PostgreSQL
module "rds" {
  source = "../modules/rds"

  project_name       = var.project_name
  environment        = var.environment
  vpc_id             = module.vpc.vpc_id
  subnet_ids         = module.vpc.private_subnet_ids  # ← Cambiar a subnet_ids
  db_name            = var.db_name
  db_username        = var.db_username
  instance_class     = var.db_instance_class
  allocated_storage  = var.db_allocated_storage
  
  allowed_security_group_id = module.eks.cluster_security_group_id  # ← Cambiar a singular
}

# Redis ElastiCache
module "redis" {
  source = "../modules/redis"

  project_name       = var.project_name
  environment        = var.environment
  vpc_id             = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnet_ids
  node_type          = var.redis_node_type
  
  allowed_security_groups = [module.eks.cluster_security_group_id]
}

# S3 Bucket
module "s3" {
  source = "../modules/s3"

  bucket_name = "${var.project_name}-images-${var.environment}-${data.aws_caller_identity.current.account_id}"
  environment = var.environment
}

# Data source para obtener el account ID
data "aws_caller_identity" "current" {}

# ECR Repositories
module "ecr" {
  source = "../modules/ecr"

  project_name = var.project_name
  environment  = var.environment
  repositories = ["backend", "frontend"]
}

# IAM Roles (IRSA)
module "iam" {
  source = "../modules/iam"

  project_name            = var.project_name
  environment             = var.environment
  cluster_name            = module.eks.cluster_name
  oidc_provider_arn       = module.eks.oidc_provider_arn
  s3_bucket_arn           = module.s3.bucket_arn
  secrets_arns            = [
    module.rds.secret_arn,
    module.redis.secret_arn
  ]
}

# Lambda Image Resizer
module "lambda" {
  source = "../modules/lambda"

  project_name   = var.project_name
  environment    = var.environment
  s3_bucket_name = module.s3.bucket_name
  s3_bucket_arn  = module.s3.bucket_arn
}
