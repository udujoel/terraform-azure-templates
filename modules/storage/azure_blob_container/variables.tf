// =====================CORE===========================
variable "storage_account" {
  type        = string
  description = "Storage Account Name"
}


// ======================Optional=======================
variable "name" {
  type        = string
  default     = "content"
  description = "Container name"
}
variable "access_type" {
  type        = string
  default     = "private"
  description = "Container Access Type: blob/container/private"
}


