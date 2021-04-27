

#Create Storage account
resource "azurerm_storage_account" "storage_account" {

  name                     = var.storage_account
  resource_group_name      = var.resource_group
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"
  #   allow_blob_public_access = true

  static_website {
    index_document     = "index.html"
    error_404_document = "error.html"
  }
}

#Add the sample index.html to blob storage
resource "azurerm_storage_blob" "blob" {
  name                   = "index.html"
  storage_account_name   = azurerm_storage_account.storage_account.name
  storage_container_name = "$web"
  type                   = "Block"
  content_type           = "text/html"
  source                 = "index.html"
}

// Azure CosmoDB
