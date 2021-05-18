// =====================CORE===========================
variable "location" {
  description = "The Azure region for resources"
  type        = string
}

variable "resource_group" {
  description = "The Azure resource group name for resources"
  type        = string
}

variable "storage_account" {
    description     = "Storage Account Name"
    type            = string
}