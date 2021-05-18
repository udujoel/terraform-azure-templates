variable "storage_account" {
  type        = string
  description = "Storage Account Name"
}
variable "location" {
  type        = string
  description = "Location of resource"
}
variable "resource_group" {
  type        = string
  description = "Resource Group Name"
}

variable "failover_location" {
  type = string
  description = "failover location for cosmodb"
}
