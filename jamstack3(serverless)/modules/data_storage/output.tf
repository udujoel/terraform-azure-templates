output "static_website_url" {
  value       = azurerm_storage_account.storage_account.primary_web_host
  description = "static web site URL from storage account"
}

output "storage_account" {
  value       = azurerm_storage_account.storage_account.name
  description = "storage account name"
}