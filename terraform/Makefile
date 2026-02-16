.PHONY: help init-infra plan-infra apply-infra init-apps plan-apps apply-apps destroy-apps destroy-infra deploy destroy

help:
	@echo "🚀 GpuChile Terraform Commands"
	@echo ""
	@echo "Full Deploy:"
	@echo "  make deploy          - Deploy infrastructure + applications"
	@echo ""
	@echo "Phase 1 - Infrastructure:"
	@echo "  make init-infra      - Initialize infrastructure"
	@echo "  make plan-infra      - Plan infrastructure"
	@echo "  make apply-infra     - Apply infrastructure"
	@echo ""
	@echo "Phase 2 - Applications:"
	@echo "  make init-apps       - Initialize applications"
	@echo "  make plan-apps       - Plan applications"
	@echo "  make apply-apps      - Apply applications"
	@echo ""
	@echo "Destroy:"
	@echo "  make destroy         - Destroy everything (apps first, then infra)"

# ===== PHASE 1: INFRASTRUCTURE =====
init-infra:
	cd 1-infrastructure && terraform init

plan-infra:
	cd 1-infrastructure && terraform plan

apply-infra:
	cd 1-infrastructure && terraform apply -auto-approve
	@echo "⏳ Waiting 3 minutes for cluster to be ready..."
	@powershell Start-Sleep -Seconds 180
	@echo "🔧 Configuring kubectl..."
	aws eks update-kubeconfig --name gpuchile-cluster --region us-east-1
	kubectl get nodes

# ===== PHASE 2: APPLICATIONS =====
init-apps:
	cd 2-applications && terraform init

plan-apps:
	cd 2-applications && terraform plan

apply-apps:
	cd 2-applications && terraform apply -auto-approve

# ===== FULL DEPLOY =====
deploy: init-infra apply-infra init-apps apply-apps
	@echo "✅ Deployment completed!"

# ===== DESTROY =====
destroy-apps:
	cd 2-applications && terraform destroy -auto-approve

destroy-infra:
	cd 1-infrastructure && terraform destroy -auto-approve

destroy: destroy-apps destroy-infra
	@echo "🗑️ Everything destroyed!"
