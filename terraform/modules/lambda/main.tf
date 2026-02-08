# IAM Role para Lambda
resource "aws_iam_role" "lambda" {
  name = "${var.function_name}-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
  })
}

# Policy para logs CloudWatch
resource "aws_iam_role_policy_attachment" "lambda_logs" {
  role       = aws_iam_role.lambda.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

# Policy para acceso a S3
resource "aws_iam_role_policy" "lambda_s3" {
  name = "lambda-s3-access"
  role = aws_iam_role.lambda.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:GetObject",
          "s3:PutObject"
        ]
        Resource = "${var.s3_bucket_arn}/*"
      }
    ]
  })
}

# Archivar el código de Lambda (tu lambda_function.py)
data "archive_file" "lambda_zip" {
  type = "zip"
  # ⚠️ Asegúrate que esta ruta coincida con tu carpeta real
  source_dir  = "${path.root}/../lambda/image-resizer"
  output_path = "${path.module}/lambda_function.zip"
}

# Función Lambda
resource "aws_lambda_function" "resizer" {
  filename      = data.archive_file.lambda_zip.output_path
  function_name = var.function_name
  role          = aws_iam_role.lambda.arn
  handler       = "lambda_function.lambda_handler"

  source_code_hash = data.archive_file.lambda_zip.output_base64sha256

  runtime     = "python3.11"
  timeout     = 30
  memory_size = 512

  # 👇 LA MAGIA: Layer pública que contiene Pillow (PIL) para Python 3.11 en us-east-1
  #layers = ["arn:aws:lambda:us-east-1:770693421928:layer:Klayers-p311-Pillow:4"] 
  # (Si falla la v4, intenta borrar la línea layers temporalmente si no es crítica la función de imágenes).


  environment {
    variables = {
      ENVIRONMENT = var.environment
    }
  }

  tags = {
    Environment = var.environment
  }
}

# Permiso para que S3 invoque la Lambda
resource "aws_lambda_permission" "allow_s3" {
  statement_id  = "AllowS3Invoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.resizer.function_name
  principal     = "s3.amazonaws.com"
  source_arn    = var.s3_bucket_arn
}

# Trigger S3 -> Lambda (cuando se sube a /original/)
resource "aws_s3_bucket_notification" "lambda_trigger" {
  bucket = var.s3_bucket_name

  lambda_function {
    lambda_function_arn = aws_lambda_function.resizer.arn
    events              = ["s3:ObjectCreated:*"]
    filter_prefix       = "original/"
  }

  depends_on = [aws_lambda_permission.allow_s3]
}