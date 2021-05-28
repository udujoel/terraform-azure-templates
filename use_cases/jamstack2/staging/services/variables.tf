// ================================================
variable "location" {
  description = "The Azure region for resources"
  type        = string
}

variable "resource_group" {
  description = "The Azure resource group name for resources"
  type        = string
}

// =======================app_service_plan=============================
variable "service_plan_name" {
    type = string
    description = "App service plan name"
}

variable "sku_tier" {
    type = string
    description = "SKU of service plan"
}
variable "sku_size" {
    type = string
    description = "Size of service plan"
}

// =======================app_service_plan=============================
variable "prefix" {
    type = string
    description = "Name prefix"
}

// =======================app_service=============================


