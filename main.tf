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
}