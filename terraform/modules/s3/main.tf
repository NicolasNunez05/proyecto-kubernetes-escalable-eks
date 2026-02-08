resource "aws_s3_bucket" "images" {
  bucket = var.bucket_name

  tags = {
    Name        = "GpuChile Images"
    Environment = var.environment
  }
}

# Bloquear acceso público a nivel de bucket (security)
resource "aws_s3_bucket_public_access_block" "images" {
  bucket = aws_s3_bucket.images.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

# Política para permitir lectura pública en /thumbnails/
resource "aws_s3_bucket_policy" "images" {
  bucket = aws_s3_bucket.images.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicReadThumbnails"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "${aws_s3_bucket.images.arn}/thumbnails/*"
      },
      {
        Sid       = "PublicReadOriginals"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "${aws_s3_bucket.images.arn}/original/*"
      }
    ]
  })
}

# CORS para que el frontend pueda cargar imágenes
resource "aws_s3_bucket_cors_configuration" "images" {
  bucket = aws_s3_bucket.images.id

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["GET", "HEAD"]
    allowed_origins = ["*"] # En prod: Especificar dominios exactos
    expose_headers  = ["ETag"]
    max_age_seconds = 3000
  }
}

# Versionado (Opcional, para recuperación)
resource "aws_s3_bucket_versioning" "images" {
  bucket = aws_s3_bucket.images.id

  versioning_configuration {
    status = "Disabled" # En prod: Enabled
  }
}
