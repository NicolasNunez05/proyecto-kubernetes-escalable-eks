variable "grafana_password" {
  description = "Contraseña de admin de Grafana"
  type        = string
  default     = "admin123"
  sensitive   = true
}
