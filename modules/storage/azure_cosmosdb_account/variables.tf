// ====================================================
variable "location" {
  description = "The Azure region for resources"
  type        = string
}

variable "resource_group" {
  description = "The Azure resource group name for resources"
  type        = string
}

// =====================CORE===========================
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



// ======================Optional=======================
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

variable "failover_failover" {
  type        = string
  default     = "westus"
  description = "The name of the Azure region to host replicated data."
}





