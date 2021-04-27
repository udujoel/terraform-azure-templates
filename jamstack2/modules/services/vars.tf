variable "resource_group" {
    type = string
    description = "resource group name"
}

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