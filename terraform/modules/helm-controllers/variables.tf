variable "cluster_name" { type = string }
variable "aws_region" { type = string }
variable "vpc_id" { type = string }
variable "oidc_provider_arn" { type = string }
variable "tags" { type = map(string) }