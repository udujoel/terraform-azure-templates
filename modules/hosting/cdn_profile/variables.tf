// ====================================================
variable "location" {
  description = "The Azure region for resources"
  type        = string
}

variable "resource_group" {
  description = "The Azure resource group name for resources"
  type        = string
}


// =====================CORE===========================
variable "profile_name" {
  type        = string
  default     = "cdn-profile"
  description = "Profile Name"
}


// ======================Optional=======================
variable "sku" {
  type        = string
  default     = "Standard_Microsoft"
  description = "SKU name: Standard_Akamai, Standard_ChinaCdn, Standard_Microsoft, Standard_Verizon or Premium_Verizon"
}

