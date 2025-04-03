terraform {
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.11"  # Use latest compatible version
    }
  }

  required_version = ">= 1.0.0"
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"  # Ensure your local K8s cluster is running
  }
}

module "nginx" {
  source             = "./modules/nginx"
  nginx_enabled      = var.nginx_enabled
  helm_chart_version = var.helm_chart_version
}

resource "helm_release" "nginx" {
  count      = var.nginx_enabled ? 1 : 0
  name       = "nginx-sample"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "nginx"
  version    = var.helm_chart_version

  values = [file("${path.module}/helm/values.yaml")]

  set {
    name  = "service.type"
    value = "ClusterIP"
  }

  depends_on = [
    helm_release.redis
  ]
}

resource "helm_release" "redis" {
  name       = "redis-sample"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "redis"
  version    = var.nginx_enabled ? "18.1.2"  : "18.0.0"

  set {
    name  = "architecture"
    value = "standalone"
  }

  set {
    name  = "auth.enabled"
    value = "false"
  }
}