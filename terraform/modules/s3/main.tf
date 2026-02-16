resource "aws_s3_bucket" "images" {
  bucket = var.bucket_name

  tags = {
    Name        = "GpuChile Images"
    Environment = var.environment
  }
}

# ====================================
# SEGURIDAD: BUCKET COMPLETAMENTE PRIVADO
# ====================================
resource "aws_s3_bucket_public_access_block" "images" {
  bucket = aws_s3_bucket.images.id

  block_public_acls       = true   # ← PRIVADO
  block_public_policy     = true   # ← PRIVADO
  ignore_public_acls      = true   # ← PRIVADO
  restrict_public_buckets = true   # ← PRIVADO
}

# ====================================
# CORS: Permite que backend/frontend suban/bajen archivos
# ====================================
resource "aws_s3_bucket_cors_configuration" "images" {
  bucket = aws_s3_bucket.images.id

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["GET", "PUT", "POST", "DELETE", "HEAD"]  # ← Agregar PUT/POST
    allowed_origins = ["*"]  # En prod: ["https://tudominio.com"]
    expose_headers  = ["ETag"]
    max_age_seconds = 3000
  }
}

# ====================================
# VERSIONADO Y LIFECYCLE
# ====================================
resource "aws_s3_bucket_versioning" "images" {
  bucket = aws_s3_bucket.images.id

  versioning_configuration {
    status = "Disabled"
  }
}

# Lifecycle: Borrar thumbnails antiguos después de 30 días
resource "aws_s3_bucket_lifecycle_configuration" "images" {
  bucket = aws_s3_bucket.images.id

  rule {
    id     = "delete-old-thumbnails"
    status = "Enabled"

    filter {
      prefix = "original/"
    }

    expiration {
      days = 30
    }
  }

  rule {
    id     = "cleanup-incomplete-uploads"
    status = "Enabled"

    abort_incomplete_multipart_upload {
      days_after_initiation = 7
    }
  }
}

# ====================================
# ENCRIPTACIÓN
# ====================================
resource "aws_s3_bucket_server_side_encryption_configuration" "images" {
  bucket = aws_s3_bucket.images.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}
