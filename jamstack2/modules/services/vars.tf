variable "resource_group_name" {
    type = string
    description = ""
}
variable "environment" {
    type = string
    description = "Name of Environment"
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