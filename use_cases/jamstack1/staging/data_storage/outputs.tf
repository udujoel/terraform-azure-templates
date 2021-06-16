output "storage_account_id" {
  value       = module.storage_account
  description = "storage account name"
}

output "storage_account_name" {
  value       = module.storage_account.storage_account_name
  description = "storage account name"
}