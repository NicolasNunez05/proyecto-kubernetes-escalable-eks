terraform {
  backend "s3" {
    bucket         = "gpuchile-tfstate-592451843842-20260210"
    key            = "eks-cluster/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "gpuchile-terraform-locks"
  }
}
