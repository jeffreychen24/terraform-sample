resource "helm_release" "nginx" {
  count      = var.nginx_enabled ? 1 : 0
  name       = "nginx-sample"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "nginx"
  version    = var.helm_chart_version

  values = [file("${path.module}/values.yaml")]

  set {
    name  = "service.type"
    value = "ClusterIP"
  }
}

module "redis" {
  source             = "./redis"
  nginx_enabled      = var.nginx_enabled
}