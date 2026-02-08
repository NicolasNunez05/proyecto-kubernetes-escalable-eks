output "vpc_id" {
  description = "El ID de la VPC creada"
  value       = module.vpc.vpc_id
}

output "private_subnets" {
  description = "Lista de IDs de las subnets privadas"
  value       = module.vpc.private_subnets
}

output "public_subnets" {
  description = "Lista de IDs de las subnets públicas"
  value       = module.vpc.public_subnets
}

output "vpc_cidr_block" {
  description = "El bloque CIDR de la VPC"
  value       = module.vpc.vpc_cidr_block
}
