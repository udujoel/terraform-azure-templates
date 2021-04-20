output "storage_account_id" {
  value       = azurerm_storage_account.storage_account.id
  description = "The ID of the storage account."
}

output "storage_account_name" {
  value       = azurerm_storage_account.storage_account.name
  description = "The name of the storage account."
}

output "static_website_cdn_endpoint_hostname" {
  value       = azurerm_cdn_endpoint.cdn_endpoint.*.name
  description = "CDN endpoint URL for Static website"
}

output "static_website_cdn_profile_name" {
  value       = azurerm_cdn_profile.cdn_profile.*.name
  description = "CDN profile name for the static website"
}

output "static_website_url" {
  value       = azurerm_storage_account.storage_account.primary_web_host
  description = "static web site URL from storage account"
}