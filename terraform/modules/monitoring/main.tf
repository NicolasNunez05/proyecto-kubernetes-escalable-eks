# 1. Extraer OIDC Provider ID
locals {
  oidc_provider_id = replace(var.oidc_provider_arn, "/^(.*provider/)/", "")
}

# 2. IAM Role para Prometheus (Con nombre de SA corregido)
resource "aws_iam_role" "prometheus" {
  name = "${var.cluster_name}-prometheus-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Principal = { Federated = var.oidc_provider_arn }
        Action    = "sts:AssumeRoleWithWebIdentity"
        Condition = {
          StringEquals = {
            # AQUÍ FORZAMOS EL NOMBRE EXACTO QUE USAREMOS EN HELM
            "${local.oidc_provider_id}:sub" = "system:serviceaccount:${var.namespace}:prometheus-sa"
            "${local.oidc_provider_id}:aud" = "sts.amazonaws.com"
          }
        }
      }
    ]
  })
}

# 3. Policy CloudWatch
resource "aws_iam_role_policy" "prometheus_cloudwatch" {
  name = "cloudwatch-access"
  role = aws_iam_role.prometheus.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = ["cloudwatch:GetMetricStatistics", "cloudwatch:ListMetrics"]
        Resource = "*"
      }
    ]
  })
}

# 4. Instalación de Prometheus con Helm (ESTILO LIMPIO)
resource "helm_release" "kube_prometheus_stack" {
  name       = "prometheus-stack"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "kube-prometheus-stack"
  namespace  = var.namespace
  create_namespace = true
  timeout    = 900
  wait       = true
  # Usamos una versión estable para evitar sorpresas
  version    = "56.0.0" 

  values = [
    yamlencode({
      # Configuración de Grafana
      grafana = {
        adminPassword = "admin" # Contraseña simple para demo
        service = {
          type = "ClusterIP"
        }
      }
      # Configuración de Prometheus
      prometheus = {
        serviceAccount = {
          create = true
          # FORZAMOS EL NOMBRE AQUÍ PARA QUE COINCIDA CON EL IAM ROLE
          name = "prometheus-sa"
          annotations = {
            "eks.amazonaws.com/role-arn" = aws_iam_role.prometheus.arn
          }
        }
        prometheusSpec = {
          # Recursos ajustados para capa gratuita/demo
          resources = {
            requests = { memory = "256Mi", cpu = "200m" }
            limits   = { memory = "1024Mi", cpu = "500m" }
          }
          # IMPORTANTE: Esto habilita la persistencia básica
          storageSpec = {
            volumeClaimTemplate = {
              spec = {
                accessModes = ["ReadWriteOnce"]
                resources = {
                  requests = { storage = "5Gi" }
                }
              }
            }
          }
        }
      }
    })
  ]
}