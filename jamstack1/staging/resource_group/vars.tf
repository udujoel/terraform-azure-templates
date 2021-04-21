variable "resource_group" {
  type        = string
  description = "Name of Resource Group"
}

variable "location" {
  type        = string
  description = "Location for Resources"
}

variable "storage" {
  type = string
  description = "Storage Account Name"
}
variable "container" {
  type = string
  description = "Blob Container Name"
}

variable "key" {
  type = string
  description = "Storage Account Key"
}