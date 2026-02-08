# terraform/backend.tf
terraform {
  backend "s3" {
    # 👇 AQUÍ PONES EL NOMBRE EXACTO QUE ACABAS DE CREAR
    bucket         = "gpuchile-terraform-state-nicolas-2026"
    key            = "eks-cluster/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "gpuchile-terraform-locks"
  }
}

