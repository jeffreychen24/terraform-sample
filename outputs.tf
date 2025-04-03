output "nginx_service" {
  value = module.nginx.nginx_service
}

output "redis_service" {
  value = module.nginx.redis_service
}