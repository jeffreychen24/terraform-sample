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