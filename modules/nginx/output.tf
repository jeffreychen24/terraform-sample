output "nginx_service" {
  value = var.nginx_enabled ? helm_release.nginx[0].name : "Nginx not installed"
}

output "redis_service" {
  value = module.redis.redis_service
}