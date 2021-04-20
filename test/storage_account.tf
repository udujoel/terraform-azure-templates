#Create Storage account
resource "azurerm_storage_account" "storage_account" {
    
  name                  = var.storage_account
  resource_group_name   = azurerm_resource_group.resource_group.name
  location              = var.location
  account_tier              = "Standard"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"
#   allow_blob_public_access = true
 
  static_website {
    index_document = "index.html"
    error_404_document = "error.html"
  }
}