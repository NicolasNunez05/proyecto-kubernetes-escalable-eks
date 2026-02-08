# terraform/main.tf

terraform {
  required_version = ">= 1.3.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.5"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.23"
    }
    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.11"
    }
  }

  # ❌ ELIMINADO: El backend "s3" ya está en backend.tf
}

provider "aws" {
  region = var.region
  default_tags {
    tags = {
      Project     = "GpuChile"
      Environment = var.environment
      ManagedBy   = "Terraform"
      Owner       = "NicolasNunez"
    }
  }
}

# Provider Kubernetes
# 🛠️ CORREGIDO PARA WINDOWS
provider "kubernetes" {
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
  
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    # 👇 RUTA ABSOLUTA A AWS CLI (Esto no puede fallar)
    command     = "C:\\Program Files\\Amazon\\AWSCLIV2\\aws.exe"
    args = [
      "eks",
      "get-token",
      "--cluster-name",
      module.eks.cluster_name
    ]
  }
}

# Provider Helm
# 🛠️ CORREGIDO: Apuntando directo al ejecutable de AWS
provider "helm" {
  kubernetes {
    host                   = module.eks.cluster_endpoint
    cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
    
    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      # 👇 LO MISMO AQUÍ
      command     = "C:\\Program Files\\Amazon\\AWSCLIV2\\aws.exe"
      args = [
        "eks",
        "get-token",
        "--cluster-name",
        module.eks.cluster_name
      ]
    }
  }
}

# 1. VPC
module "vpc" {
  source = "./modules/vpc"

  vpc_cidr     = var.vpc_cidr
  environment  = var.environment
  cluster_name = var.cluster_name
}

# 2. EKS
module "eks" {
  source = "./modules/eks"

  cluster_name = var.cluster_name
  vpc_id       = module.vpc.vpc_id
  subnet_ids   = module.vpc.public_subnets
  environment  = var.environment

 
  cluster_version = "1.31"
}

# 3. RDS
module "rds" {
  source = "./modules/rds"

  environment               = var.environment
  vpc_id                    = module.vpc.vpc_id
  subnet_ids                = module.vpc.public_subnets
  allowed_security_group_id = module.eks.cluster_security_group_id
}

# 4. S3
module "s3" {
  source = "./modules/s3"

  environment = var.environment
  bucket_name = "gpuchile-images-${var.environment}-nicolas-2026"
}

# 5. Lambda
module "lambda" {
  source = "./modules/lambda"

  environment      = var.environment
  s3_bucket_name   = module.s3.bucket_name
  s3_bucket_arn    = module.s3.bucket_arn
}

# 6. Secretos Adicionales (JWT, Redis)
module "secrets" {
  source = "./modules/secrets"

  environment = var.environment
}

# 7. IRSA Role para el Backend
module "backend_irsa" {
  source = "./modules/irsa"

  cluster_name         = var.cluster_name
  oidc_provider_arn    = module.eks.oidc_provider_arn
  namespace            = "default"
  service_account_name = "gpuchile-backend-sa"
  s3_bucket_arn        = module.s3.bucket_arn
  
  secrets_arns = [
    module.rds.db_secret_arn,
    module.secrets.jwt_secret_arn,
    module.secrets.redis_secret_arn
  ]
}

# 8. ECR (Comentado porque ya existe)
# module "ecr" { ... }

# 9. Monitoring
#module "monitoring" {
#  source = "./modules/monitoring"

#  cluster_name      = module.eks.cluster_name
#  oidc_provider_arn = module.eks.oidc_provider_arn
#  namespace         = "monitoring"
  
#  depends_on = [ module.eks ]
#}

# 10. Helm Controllers (Comentado temporalmente para fase 1, o descoméntalo si Monitoring funciona)

module "helm_controllers" {
  source = "./modules/helm-controllers"

  cluster_name      = module.eks.cluster_name 
  aws_region        = var.region
  vpc_id            = module.vpc.vpc_id
  oidc_provider_arn = module.eks.oidc_provider_arn
  
  tags = {
    Environment = var.environment
    Project     = "GpuChile"
  }

  depends_on = [
    module.eks
  ]
}
