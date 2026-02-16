# =============================================================================
# Módulo: Helm Controllers Completo
# AWS LB Controller + External Secrets + Prometheus + Cluster Autoscaler
# =============================================================================

terraform {
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.12"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.25"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# -----------------------------------------------------------------------------
# Data Sources
# -----------------------------------------------------------------------------

data "aws_caller_identity" "current" {}

# -----------------------------------------------------------------------------
# 1. AWS LOAD BALANCER CONTROLLER (CRÍTICO)
# -----------------------------------------------------------------------------

module "aws_lb_controller_irsa" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
  version = "~> 5.34"

  role_name = "${var.cluster_name}-aws-lb-controller"

  attach_load_balancer_controller_policy = true

  oidc_providers = {
    main = {
      provider_arn               = var.oidc_provider_arn
      namespace_service_accounts = ["kube-system:aws-load-balancer-controller"]
    }
  }

  tags = var.tags
}

resource "helm_release" "aws_lb_controller" {
  name       = "aws-load-balancer-controller"
  repository = "https://aws.github.io/eks-charts"
  chart      = "aws-load-balancer-controller"
  version    = "1.7.1"
  namespace  = "kube-system"

  set {
    name  = "clusterName"
    value = var.cluster_name
  }

  set {
    name  = "serviceAccount.create"
    value = "true"
  }

  set {
    name  = "serviceAccount.name"
    value = "aws-load-balancer-controller"
  }

  set {
    name  = "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = module.aws_lb_controller_irsa.iam_role_arn
  }

  set {
    name  = "region"
    value = var.aws_region
  }

  set {
    name  = "vpcId"
    value = var.vpc_id
  }

  depends_on = [module.aws_lb_controller_irsa]
}

# -----------------------------------------------------------------------------
# 2. METRICS SERVER (necesario para HPA)
# -----------------------------------------------------------------------------

resource "helm_release" "metrics_server" {
  count = var.enable_metrics_server ? 1 : 0

  name       = "metrics-server"
  repository = "https://kubernetes-sigs.github.io/metrics-server/"
  chart      = "metrics-server"
  namespace  = "kube-system"
  version    = "3.11.0"

  set {
    name  = "args[0]"
    value = "--kubelet-insecure-tls"
  }
}

# -----------------------------------------------------------------------------
# 3. EXTERNAL SECRETS OPERATOR
# -----------------------------------------------------------------------------

resource "aws_iam_policy" "external_secrets" {
  count = var.enable_external_secrets ? 1 : 0

  name        = "${var.cluster_name}-external-secrets-policy"
  description = "IAM policy for External Secrets Operator"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "secretsmanager:GetResourcePolicy",
          "secretsmanager:GetSecretValue",
          "secretsmanager:DescribeSecret",
          "secretsmanager:ListSecretVersionIds"
        ]
        Resource = "arn:aws:secretsmanager:${var.aws_region}:${data.aws_caller_identity.current.account_id}:secret:*"
      },
      {
        Effect = "Allow"
        Action = ["secretsmanager:ListSecrets"]
        Resource = "*"
      }
    ]
  })

  tags = var.tags
}

module "external_secrets_irsa" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
  version = "~> 5.34"

  count = var.enable_external_secrets ? 1 : 0

  role_name = "${var.cluster_name}-external-secrets"

  role_policy_arns = {
    policy = aws_iam_policy.external_secrets[0].arn
  }

  oidc_providers = {
    main = {
      provider_arn               = var.oidc_provider_arn
      namespace_service_accounts = ["external-secrets:external-secrets"]
    }
  }

  tags = var.tags
}

resource "kubernetes_namespace" "external_secrets" {
  count = var.enable_external_secrets ? 1 : 0

  metadata {
    name = "external-secrets"
  }
}

resource "helm_release" "external_secrets" {
  count = var.enable_external_secrets ? 1 : 0

  name       = "external-secrets"
  repository = "https://charts.external-secrets.io"
  chart      = "external-secrets"
  version    = "0.9.13"
  namespace  = kubernetes_namespace.external_secrets[0].metadata[0].name

  set {
    name  = "installCRDs"
    value = "true"
  }

  set {
    name  = "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = module.external_secrets_irsa[0].iam_role_arn
  }

  depends_on = [
    kubernetes_namespace.external_secrets,
    module.external_secrets_irsa
  ]
}

resource "kubernetes_manifest" "secret_store" {
  count = var.enable_external_secrets ? 1 : 0

  depends_on = [helm_release.external_secrets]

  manifest = {
    apiVersion = "external-secrets.io/v1beta1"
    kind       = "ClusterSecretStore"
    metadata = {
      name = "aws-secrets-manager"
    }
    spec = {
      provider = {
        aws = {
          service = "SecretsManager"
          region  = var.aws_region
          auth = {
            jwt = {
              serviceAccountRef = {
                name      = "external-secrets"
                namespace = "external-secrets"
              }
            }
          }
        }
      }
    }
  }
}



# -----------------------------------------------------------------------------
# 4. PROMETHEUS + GRAFANA
# -----------------------------------------------------------------------------



resource "helm_release" "kube_prometheus_stack" {
  count            = var.enable_prometheus ? 1 : 0
  name             = "prometheus-stack"
  repository       = "https://prometheus-community.github.io/helm-charts"
  chart            = "kube-prometheus-stack"
  namespace        = "monitoring"
  create_namespace = true
  timeout          = 900
  wait             = true
  version          = "56.0.0" 

  values = [
    yamlencode({
      # Configuración de Grafana
      grafana = {
        adminPassword = var.grafana_admin_password
        service = {
          type = "ClusterIP"
        }
      }
      # Configuración de Prometheus
      prometheus = {
        serviceAccount = {
          create = true
          name = "prometheus-sa"
          annotations = {
            "eks.amazonaws.com/role-arn" = var.prometheus_role_arn
          }
        }
        prometheusSpec = {
          serviceAccountName = "prometheus-sa"
          resources = {
            requests = { memory = "256Mi", cpu = "200m" }
            limits   = { memory = "1024Mi", cpu = "500m" }
          }
          # ALMACENAMIENTO: Configuración estándar
          storageSpec = {
            volumeClaimTemplate = {
              spec = {
                storageClassName = "gp3"   # <--- ESTA LÍNEA ES LA CLAVE
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

# -----------------------------------------------------------------------------
# 5. CLUSTER AUTOSCALER
# -----------------------------------------------------------------------------

resource "helm_release" "cluster_autoscaler" {
  count = var.enable_cluster_autoscaler ? 1 : 0

  name       = "cluster-autoscaler"
  repository = "https://kubernetes.github.io/autoscaler"
  chart      = "cluster-autoscaler"
  namespace  = "kube-system"
  version    = "9.29.3"

  set {
    name  = "autoDiscovery.clusterName"
    value = var.cluster_name
  }

  set {
    name  = "awsRegion"
    value = var.aws_region
  }

  set {
    name  = "rbac.serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = var.cluster_autoscaler_role_arn
  }

  depends_on = [helm_release.metrics_server]
}

# -----------------------------------------------------------------------------
# 6. FLUENT BIT (Logging)
# -----------------------------------------------------------------------------

resource "kubernetes_namespace" "logging" {
  count = var.enable_fluent_bit ? 1 : 0

  metadata {
    name = "logging"
  }
}

resource "helm_release" "fluent_bit" {
  count = var.enable_fluent_bit ? 1 : 0

  name       = "fluent-bit"
  repository = "https://fluent.github.io/helm-charts"
  chart      = "fluent-bit"
  namespace  = kubernetes_namespace.logging[0].metadata[0].name
  version    = "0.43.0"

  set {
    name  = "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = var.fluent_bit_role_arn
  }

  set {
  name  = "config.outputs"
  value = <<-EOT
    [OUTPUT]
        Name cloudwatch_logs
        Match *
        region ${var.aws_region}
        log_group_name ${var.log_group_name}
        log_stream_prefix fluent-bit-
        auto_create_group true
  EOT
}

  depends_on = [kubernetes_namespace.logging]
}

