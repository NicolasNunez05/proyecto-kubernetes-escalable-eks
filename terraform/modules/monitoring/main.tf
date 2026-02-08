# 1. Extraer OIDC Provider ID
locals {
  oidc_provider_id = replace(var.oidc_provider_arn, "/^(.*provider/)/", "")
}

# 2. IAM Role para Prometheus
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
            "${local.oidc_provider_id}:sub" = "system:serviceaccount:${var.namespace}:prometheus-stack-kube-prom-prometheus"
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

# 4. Instalación de Prometheus con Helm (ESTILO YAML)
resource "helm_release" "kube_prometheus_stack" {
  name             = "prometheus-stack"
  repository       = "https://prometheus-community.github.io/helm-charts"
  chart            = "kube-prometheus-stack"
  namespace        = var.namespace
  create_namespace = true
  timeout = 900   # 900 segundos = 15 minutos
  wait    = true

  # ⚠️ AQUÍ ESTÁ EL CAMBIO MÁGICO
  # En lugar de usar 'set {}', usamos 'values' con YAML.
  # Esto evita el error de "Unsupported block type".
  values = [
    yamlencode({
      grafana = {
        adminPassword = "admin123"
      }
      prometheus = {
        prometheusSpec = {
          resources = {
            requests = { memory = "256Mi" }
            limits   = { memory = "512Mi" }
          }
          serviceAccount = {
            annotations = {
              "eks.amazonaws.com/role-arn" = aws_iam_role.prometheus.arn
            }
          }
        }
      }
    })
  ]
}