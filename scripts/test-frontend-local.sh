#!/bin/bash
set -e

echo "🎨 Testing Frontend Build Locally..."

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Cleanup function
cleanup() {
    echo -e "${YELLOW}🧹 Cleaning up...${NC}"
    kind delete cluster --name test-frontend 2>/dev/null || true
    docker rm -f test-nginx 2>/dev/null || true
}

trap cleanup EXIT

echo -e "${YELLOW}📦 Step 1: Building Frontend...${NC}"
cd apps/frontend
npm install
npm run build

if [ ! -f "dist/index.html" ]; then
    echo -e "${RED}❌ Build failed: index.html not found${NC}"
    exit 1
fi

echo -e "${GREEN}✅ Frontend built successfully${NC}"

echo -e "${YELLOW}🐳 Step 2: Building Docker Image...${NC}"
docker build -t gpuchile-frontend:test .

echo -e "${GREEN}✅ Docker image built${NC}"

echo -e "${YELLOW}🧪 Step 3: Testing with Docker directly...${NC}"
docker run -d --name test-nginx -p 8080:80 gpuchile-frontend:test
sleep 3

HTTP_CODE=$(curl -o /dev/null -s -w "%{http_code}" http://localhost:8080/)
if [ "$HTTP_CODE" == "200" ]; then
    echo -e "${GREEN}✅ Docker test passed (HTTP $HTTP_CODE)${NC}"
else
    echo -e "${RED}❌ Docker test failed (HTTP $HTTP_CODE)${NC}"
    exit 1
fi

echo -e "${YELLOW}☸️ Step 4: Testing with Kind...${NC}"
kind create cluster --name test-frontend

# Configure kubectl
kind export kubeconfig --name test-frontend

# Load image
kind load docker-image gpuchile-frontend:test --name test-frontend

# Deploy
kubectl create configmap frontend-config --from-literal=VITE_API_URL=http://backend:8000/api
kubectl apply -f ../../k8s-local/frontend-deployment.yaml
kubectl apply -f ../../k8s-local/frontend-service.yaml

# Wait
echo -e "${YELLOW}⏳ Waiting for deployment...${NC}"
kubectl wait --for=condition=available --timeout=120s deployment/gpuchile-frontend

# Test
kubectl port-forward service/frontend-service 8081:80 &
PF_PID=$!
sleep 5

HTTP_CODE=$(curl -o /dev/null -s -w "%{http_code}" http://localhost:8081/)
if [ "$HTTP_CODE" == "200" ]; then
    echo -e "${GREEN}✅ Kind test passed (HTTP $HTTP_CODE)${NC}"
else
    echo -e "${RED}❌ Kind test failed (HTTP $HTTP_CODE)${NC}"
    kill $PF_PID
    exit 1
fi

kill $PF_PID

echo -e "${GREEN}✅ All tests passed!${NC}"
echo -e "${GREEN}🎉 Frontend is ready for production deployment${NC}"
