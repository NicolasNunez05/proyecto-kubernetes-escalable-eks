<div align="center">

![Terraform](https://img.shields.io/badge/Terraform-7B42BC?style=for-the-badge&logo=terraform&logoColor=white)
![Kubernetes](https://img.shields.io/badge/Kubernetes-326CE5?style=for-the-badge&logo=kubernetes&logoColor=white)
![AWS](https://img.shields.io/badge/AWS-232F3E?style=for-the-badge&logo=amazon-aws&logoColor=white)
![React](https://img.shields.io/badge/React-20232A?style=for-the-badge&logo=react&logoColor=61DAFB)
![FastAPI](https://img.shields.io/badge/FastAPI-005571?style=for-the-badge&logo=fastapi)

</div>

# GPUCHILE - Production-Grade EKS Project

## Descripción

E-commerce de GPUs high-performance desplegado en AWS EKS con arquitectura production-ready. Proyecto portfolio que demuestra:

- Infrastructure as Code (Terraform)
- Container Orchestration (Kubernetes/EKS)
- CI/CD Pipeline (GitHub Actions)
- Microservicios (FastAPI + React)
- Observability (Prometheus + Grafana)
- Security-first (IRSA, Secrets Manager, Network Policies)

---

## Arquitectura

### Stack Técnico

FRONTEND BACKEND DATA INFRA
graph TD
    User((Usuario)) --> ALB(AWS Load Balancer)
    subgraph AWS Cloud
        ALB --> Ingress[Nginx Ingress]
        subgraph EKS Cluster
            Ingress --> Frontend[Frontend Pods <br/> React + Nginx]
            Frontend --> Backend[Backend Pods <br/> FastAPI]
            Backend --> Redis[(Redis Cache)]
        end
        Backend --> RDS[(RDS PostgreSQL)]
        Backend --> S3[S3 Bucket <br/> Images]
        GitHub[GitHub Actions] --> ECR[AWS ECR]
        ECR --> EKS
    end


### Flujo de Datos

Usuario → ALB → Ingress → Frontend (Nginx) → Backend (FastAPI) → RDS
↓ ↓
S3 Images Redis Cache


### Componentes AWS

- **Compute:** EKS Cluster (1-3 nodos Spot t3.medium)
- **Networking:** VPC Multi-AZ, Subnets públicas/privadas, ALB
- **Data:** RDS PostgreSQL, Redis en K8s, S3 para imágenes
- **Security:** IRSA roles, Secrets Manager, Security Groups
- **Observability:** Prometheus + Grafana (Helm)
- **CI/CD:** GitHub Actions con OIDC, ECR

---

## Quick Start

### Requisitos Previos

```bash
# Verificar herramientas instaladas
terraform --version  # >= 1.6.0
kubectl version --client
helm version
aws --version
docker --version

Setup Inicial

# 1. Clonar repositorio
git clone https://github.com/NicolasNunez05/proyecto-kubernetes-escalable-eks.git
cd proyecto-kubernetes-escalable-eks

# 2. Configurar AWS CLI
aws configure
# Ingresar: Access Key, Secret Key, Region (us-east-1)

# 3. Crear infraestructura AWS
cd terraform
terraform init
terraform plan
terraform apply  # Toma 15-20 min

# 4. Configurar kubectl
aws eks update-kubeconfig --name gpuchile-cluster --region us-east-1

# 5. Instalar External Secrets Operator
helm repo add external-secrets https://charts.external-secrets.io
helm repo update  
helm install external-secrets external-secrets/external-secrets \
  --namespace external-secrets --create-namespace

# 6. Aplicar manifiestos K8s
kubectl apply -f kubernetes/external-secrets/
kubectl apply -f kubernetes/redis/

# 7. Build y push imágenes a ECR
./scripts/docker/build_and_push.sh

# 8. Desplegar aplicaciones con Helm
helm install gpuchile-backend ./helm/backend --namespace default
helm install gpuchile-frontend ./helm/frontend --namespace default

# 9. Obtener URL del LoadBalancer
kubectl get svc gpuchile-frontend -n default
# EXTERNAL-IP es la URL de la app

Estructura del Proyecto

.
├── apps/
│   ├── backend/           # FastAPI + PostgreSQL + Redis
│   │   ├── app/
│   │   │   ├── api/routes/
│   │   │   ├── db/
│   │   │   ├── models/
│   │   │   └── main.py
│   │   ├── Dockerfile
│   │   └── requirements.txt
│   └── frontend/          # React + Nginx
│       ├── src/
│       ├── Dockerfile
│       └── nginx.conf
├── terraform/             # Infrastructure as Code
│   ├── modules/
│   │   ├── vpc/
│   │   ├── eks/
│   │   ├── rds/
│   │   ├── s3/
│   │   ├── lambda/
│   │   ├── ecr/
│   │   ├── irsa/
│   │   └── secrets/
│   ├── main.tf
│   ├── variables.tf
│   └── outputs.tf
├── helm/                  # Kubernetes Helm Charts
│   ├── backend/
│   └── frontend/
├── kubernetes/            # Raw K8s manifests
│   ├── external-secrets/
│   └── redis/
├── .github/workflows/     # CI/CD Pipelines
│   ├── backend-ci.yml
│   └── frontend-ci.yml
├── lambda/                # Serverless Image Resizer
│   └── image-resizer/
├── scripts/               # Automation
│   ├── docker/
│   └── ops/
└── docs/                  # Documentation

Desarrollo Local
Backend

cd apps/backend
python -m venv venv
source venv/bin/activate
pip install -r requirements.txt
python -m app.main
# API en http://localhost:8000
# Docs en http://localhost:8000/docs

Frontend
cd apps/frontend
npm install
npm run dev
# App en http://localhost:5173

Docker Compose (Fullstack Local)
cd apps/backend
docker-compose up
# Backend: http://localhost:8000
# Frontend: http://localhost:5173
# Adminer (DB GUI): http://localhost:8080

Secrets Management

Las credenciales se gestionan con AWS Secrets Manager y se inyectan en pods vía External Secrets Operator.
Secretos almacenados:

    gpuchile/dev/db → PostgreSQL URL

    gpuchile/dev/jwt → JWT secret

    gpuchile/dev/redis → Redis URL

Observability
Prometheus + Grafana

# Acceder a Grafana
kubectl port-forward -n monitoring svc/prometheus-stack-grafana 3000:80
# Usuario: admin
# Password: admin123

# Dashboards disponibles:
# - Kubernetes Cluster Monitoring
# - Node Exporter Full
# - FastAPI Custom Metrics

Gestión de Costos
Costo por hora: aproximadamente $0.12 USD

    EKS Control Plane: $0.10/h

    EC2 Spot t3.medium (1 nodo): aproximadamente $0.015/h

    RDS t3.micro: Free Tier

    S3/Lambda: Pay-per-use (aproximadamente $0.01/día)

Destroy después de usar

cd terraform
terraform destroy  # Libera TODOS los recursos

Roadmap

    Iteración 1: Walking Skeleton (App en EKS)

    Iteración 2: Helm Charts

    Iteración 3: CI/CD Pipeline

    Iteración 4: Observability (Prometheus/Grafana)

    Iteración 5: Autoscaling (HPA + Cluster Autoscaler)

    Iteración 6: Networking (ExternalDNS + Ingress)

    Iteración 7: Logging (Fluent Bit + OpenSearch)

Contribuciones
Este es un proyecto portfolio personal. Si encuentras bugs o mejoras, abre un issue.

Licencia
MIT License - Ver LICENSE

Autor

Nicolás Núñez

    GitHub: @NicolasNunez05

    LinkedIn: https://www.linkedin.com/in/nicol%C3%A1s-n%C3%BA%C3%B1ez-%C3%A1lvarez-35ba661ba/

    Email: nicolasnunezalvarez05@gmail.com

Aprendizajes Clave

Este proyecto me enseñó:

    Diseño de arquitecturas multi-tier en AWS

    Orquestación de contenedores con Kubernetes

    Automatización de despliegues con GitOps

    Gestión de secretos y seguridad en cloud

    Observability con métricas y dashboards

    Trade-offs entre costos y disponibilidad

Objetivo: Demostrar competencias para posiciones Cloud/DevOps Engineer.
