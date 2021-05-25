// ====================================================

variable "resource_group" {
  description = "The Azure resource group name for resources"
  type        = string
}


// =====================CORE===========================
variable "dns_zone" {
  type        = string
  description = "DNS Zone Name"
}
variable "cdn_endpoint" {
  type        = string
  description = "CDN Endpoint Name"
}

// =====================Optional===========================
variable "ttl" {
  default     = 300
  description = "Time to live"
}
