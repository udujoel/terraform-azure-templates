=====================CORE===========================
variable "storage_account" {
  type        = string
  description = "Storage Account Name"
}
variable "location" {
  type        = string
  default     = "eastus"
  description = "Location of resource"
}
variable "resource_group" {
  type        = string
  description = "Resource Group Name"
}

======================Optional=======================
variable "tier" {
  type        = string
  default     = "Standard"
  description = "Account tier"
}
variable "type" {
  type        = string
  default     = "LRS"
  description = "Replication type"
}
variable "kind" {
  type        = string
  default     = "StorageV2"
  description = "Account kind"
}
variable "index_document" {
  type        = string
  default     = "index.html"
  description = "Default Index document"
}
variable "error_document" {
  type        = string
  default     = "error.html"
  description = "Default Error document"
}


