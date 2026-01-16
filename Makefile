.PHONY: dev test build deploy

# Desarrollo local
dev-backend:
	cd apps/backend && uvicorn app.main:app --reload

dev-frontend:
	cd apps/frontend && npm start

# Tests
test-backend:
	cd apps/backend && pytest -v

test-integration:
	cd apps/backend && pytest tests/ -m integration

# Docker
build-backend:
	docker build -t gpuchile/backend:latest apps/backend

build-frontend:
	docker build -t gpuchile/frontend:latest apps/frontend

# Terraform
tf-init:
	cd terraform && terraform init

tf-plan:
	cd terraform && terraform plan

tf-apply:
	cd terraform && terraform apply -auto-approve

# Kubernetes
k8s-apply:
	kubectl apply -f kubernetes/base/

helm-backend:
	helm upgrade --install backend helm/backend -f helm/backend/values-prod.yaml
