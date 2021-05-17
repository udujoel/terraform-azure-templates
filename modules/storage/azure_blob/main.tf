//=====================================================================================================================
// Azure Blob Storage
//=====================================================================================================================

// add a sample index.html to blob storage
// for hosting a static site, use '$web' as container_name
// https://docs.microsoft.com/en-us/azure/storage/blobs/storage-blob-static-website

resource "azurerm_storage_blob" "blob" {
  name                   = var.file_name
  storage_account_name   = var.storage_account_name
  storage_container_name = var.container_name
  type                   = var.type
  content_type           = var.content_type
  access_tier            = var.access_tier
  source                 = "./index.html"
}