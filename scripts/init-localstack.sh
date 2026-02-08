#!/bin/bash
set -e

echo "🚀 Initializing LocalStack..."

# Esperar a que LocalStack esté listo
echo "⏳ Waiting for LocalStack..."
until curl -s http://localhost:4566/_localstack/health | grep '"s3": "available"'; do
  sleep 2
done

echo "✅ LocalStack is ready!"

# Crear bucket S3
echo "📦 Creating S3 bucket..."
awslocal s3 mb s3://gpuchile-dev || echo "Bucket already exists"

# Listar buckets
echo "📋 Available buckets:"
awslocal s3 ls

# (Opcional) Crear secreto en Secrets Manager
# awslocal secretsmanager create-secret \
#   --name gpuchile/db \
#   --secret-string '{"username":"postgres","password":"postgres123"}'

echo "✅ LocalStack initialization complete!"
