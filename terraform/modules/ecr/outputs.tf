output "repository_urls" {
  description = "Map de nombres a URLs de los repositorios ECR"
  value = {
    for name, repo in aws_ecr_repository.repos :
    name => repo.repository_url
  }
}

output "repository_arns" {
  description = "Map de nombres a ARNs de los repositorios"
  value = {
    for name, repo in aws_ecr_repository.repos :
    name => repo.arn
  }
}
