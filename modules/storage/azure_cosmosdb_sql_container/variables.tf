// ====================================================
variable "location" {
  type        = string
  description = "The Azure region for resources"
}

variable "resource_group" {
  type        = string
  description = "The Azure resource group name for resources"
}

variable "cosmosdb_account_name" {
  type        = string
  description = "Cosmosdb Account Name"
}

variable "cosmosdb_sql_database_name" {
  type        = string
  description = "Cosmosdb SQL DB Name"
}


// ======================Optional=======================
variable "partition_key_path" {
  type        = string
  default     = "/definition/id"
  description = "Partition key path"
}





