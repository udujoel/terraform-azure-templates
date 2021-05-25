// ========================General============================
variable "location" {
  type        = string
  description = "The Azure region for resources"
}

variable "resource_group" {
  type        = string
  description = "The Azure resource group name for resources"
}

// =====================cdn_profile===========================
variable "profile_name" {
  type        = string
  default     = "cdn-profile"
  description = "Profile Name"
}

variable "sku" {
  type        = string
  default     = "Standard_Microsoft"
  description = "SKU name: Standard_Akamai, Standard_ChinaCdn, Standard_Microsoft, Standard_Verizon or Premium_Verizon"
}

// =====================cdn_endpoint===========================
variable "storage_account" {
  type        = string
  description = "Storage Account Name"
}

// =====================dns_cname_record===========================
variable "dns_zone" {
  type        = string
  description = "DNS Zone Name"
}

variable "cdn_endpoint" {
  type        = string
  description = "CDN Endpoint Name"
}

variable "ttl" {
  default     = 300
  description = "Time to live"
}
