output "bucket_name" {
  description = "Nombre del bucket S3"
  value       = aws_s3_bucket.images.id
}

output "bucket_arn" {
  description = "ARN del bucket S3"
  value       = aws_s3_bucket.images.arn
}

output "bucket_regional_domain_name" {
  description = "Domain name regional del bucket"
  value       = aws_s3_bucket.images.bucket_regional_domain_name
}
