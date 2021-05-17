//=====================================================================================================================
// Azure Storage Account
//=====================================================================================================================

resource "azurerm_storage_account" "storage_account" {

  name                     = var.storage_account
  resource_group_name      = var.resource_group
  location                 = var.location
  account_tier             = var.tier
  account_replication_type = var.type
  account_kind             = var.kind

  static_website {
    index_document     = var.index_document
    error_404_document = var.error_document
  }
}
