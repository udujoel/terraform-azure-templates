// ======================================================
variable "location" {
  type        = string
  description = "The Azure region for resources"
}

variable "resource_group" {
  type        = string
  description = "The Azure resource group name for resources"
}

// =====================storage account===========================

variable "storage_account" {
    type            = string
    description     = "Storage Account Name"
}

// =====================cosmosdb account===========================

variable "name_prefix" {
  type        = string
  default     = "tfex-cosmos-db"
  description = "Account name prefix"
}

variable "offer_type" {
  type        = string
  default     = "Standard"
  description = "Account Offer type"
}

variable "kind" {
  type        = string
  default     = "GlobalDocumentDB"
  description = "Account Kind: possible values are GlobalDocumentDB and MongoDB"
}

variable "enable_automatic_failover" {
  type        = bool
  default     = true
  description = "Enable automatic fail over for this Cosmos DB account."
}

variable "failover_location" {
  type        = string
  default     = "westus"
  description = "The name of the Azure region to host replicated data."
}

// =====================cosmosdb_sql_database===========================

variable "cosmosdb_account_name" {
  description = "The Azure resource group name for resources"
  type        = string
}

// =====================cosmosdb_sql_container===========================

variable "cosmosdb_sql_database_name" {
  type        = string
  description = "Cosmosdb SQL DB Name"
}
