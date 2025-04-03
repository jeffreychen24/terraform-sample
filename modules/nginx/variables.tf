variable "nginx_enabled" {
  description = "Enable or disable Nginx installation"
  type        = bool
}

variable "helm_chart_version" {
  description = "Nginx Helm chart version"
  type        = string
}