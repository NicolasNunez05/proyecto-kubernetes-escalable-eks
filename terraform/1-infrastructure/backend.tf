terraform {
  backend "s3" {
    bucket         = "gpuchile-tfstate-592451843842-20260210"
    key            = "infrastructure/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    # DynamoDB table es opcional para locking
    # dynamodb_table = "terraform-locks"
  }
}
