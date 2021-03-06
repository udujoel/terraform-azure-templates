// =====================CORE===========================
variable "storage_account" {
  type        = string
  description = "Storage Account Name"
}

variable "resource_group" {
  type        = string
  description = "Resource group for resources"
}


// ======================Optional=======================
variable "file_name" {
  type        = string
  default     = "index.html"
  description = "Blob file name"
}
variable "container_name" {
  type        = string
  default     = "$web"
  description = "Blob container name (https://docs.microsoft.com/en-us/azure/storage/blobs/storage-blob-static-website)"
}
variable "type" {
  type        = string
  default     = "Block"
  description = "Blob type: 'Append'/'Block'/'Page' (https://docs.microsoft.com/en-us/azure/storage/blobs/storage-blobs-introduction#blobs)"
}
variable "content_type" {
  type        = string
  default     = "text/html"
  description = "Content type"
}
variable "access_tier" {
  type        = string
  default     = "Hot"
  description = "Access Tier: 'Archive'/'Cool'/'Hot'"
}

