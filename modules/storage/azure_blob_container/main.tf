//=====================================================================================================================
// Azure Blob Container
//=====================================================================================================================

// create an azure Blob storage container



resource "azurerm_storage_container" "container" {
  name                  = var.name
  storage_account_name  = var.storage_account
  container_access_type = var.access_type
}