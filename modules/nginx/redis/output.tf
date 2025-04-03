output "redis_service" {
  value = helm_release.redis.name
}