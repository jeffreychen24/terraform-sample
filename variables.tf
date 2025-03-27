variable "helm_chart_version" {
  description = "Version of the Nginx Helm chart"
  type        = string
  default     = "15.5.1"
}

variable "nginx_enabled" {
  description = "Enable or disable the Nginx Helm chart"
  type        = bool
  default     = true
}