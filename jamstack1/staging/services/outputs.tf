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