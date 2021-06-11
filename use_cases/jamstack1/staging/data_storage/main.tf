// Storage Account
module "storage_account" {
source              = "../../../../modules/storage/storage_account"

location            = var.location
resource_group      = var.resource_group
storage_account     = var.storage_account
}

// Blob
module "azure_blob" {
source              = "../../../../modules/storage/azure_blob"
resource_group      = var.resource_group
storage_account     = var.storage_account
}