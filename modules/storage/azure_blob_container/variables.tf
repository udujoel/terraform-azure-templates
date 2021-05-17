=====================CORE===========================
variable "storage_account_name" {
  type        = string
  description = "Storage Account Name"
}


======================Optional=======================
variable "name" {
  type        = string
  default     = "content"
  description = "Container name"
}
variable "access_type" {
  type        = string
  default     = "private"
  description = "Container Access Type"
}


