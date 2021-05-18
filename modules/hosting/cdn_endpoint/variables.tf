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
variable "storage_account" {
  type        = string
  description = "Storage Account Name"
}

variable "profile_name" {
  type        = string
  default     = "cdn-profile"
  description = "Profile Name"
}

