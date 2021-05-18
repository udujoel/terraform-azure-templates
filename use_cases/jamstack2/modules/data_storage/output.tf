output "static_website_url" {
  value       = azurerm_storage_account.storage_account.primary_web_host
  description = "static web site URL from storage account"
}

output "storage_account" {
  value       = azurerm_storage_account.storage_account.name
  description = "storage account name"
}

output  "cosmodb_account_name" {
  value       = azurerm_cosmosdb_account.db.name
  description = "name of cosmodb account"
}

output  "cosmodb_sql_db_name" {
  value       = azurerm_cosmosdb_sql_database.db.name
  description = "name of cosmodb sql database"
}

output  "cosmodb_sql_container_name" {
  value       = azurerm_cosmosdb_sql_container.container.name
  description = "name of cosmodb sql collection"
}