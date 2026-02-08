#!/bin/bash
set -e

# Colores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}🚀 Build and Push Script para ECR${NC}"

# Variables (ajustar según tu cuenta)
AWS_REGION="us-east-1"
AWS_ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)
BACKEND_REPO="gpuchile-backend"
FRONTEND_REPO="gpuchile-frontend"

# Login a ECR
echo -e "${YELLOW}📝 Login a ECR...${NC}"
aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com

# Build y push Backend
echo -e "${YELLOW}🔨 Building backend...${NC}"
cd ../../apps/backend
docker build -t $BACKEND_REPO:latest .
docker tag $BACKEND_REPO:latest $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$BACKEND_REPO:latest
echo -e "${YELLOW}📤 Pushing backend...${NC}"
docker push $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$BACKEND_REPO:latest

# Build y push Frontend
echo -e "${YELLOW}🔨 Building frontend...${NC}"
cd ../frontend
docker build -t $FRONTEND_REPO:latest .
docker tag $FRONTEND_REPO:latest $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$FRONTEND_REPO:latest
echo -e "${YELLOW}📤 Pushing frontend...${NC}"
docker push $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$FRONTEND_REPO:latest

echo -e "${GREEN}✅ Build and push completed successfully!${NC}"
echo -e "${GREEN}Backend: $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$BACKEND_REPO:latest${NC}"
echo -e "${GREEN}Frontend: $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$FRONTEND_REPO:latest${NC}"
