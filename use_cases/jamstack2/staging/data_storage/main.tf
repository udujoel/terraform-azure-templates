// Storage Account
module "storage_account" {
source              = "../../../../modules/storage/storage_account"

location            = var.location
resource_group      = var.resource_group
storage_account     = var.storage_account
}

// Blob
module "azure_blob" {
source              = "../../../../modules/storage/azure_blob"

storage_account     = var.storage_account
}

// cosmosdb account
module "cosmosdb_account" {
source              = "../../../../modules/storage/azure_cosmosdb_account"

// name                = "${var.name_prefix}-${random_integer.unique.result}"
location            = var.location
resource_group_name = var.resource_group
offer_type          = var.offer_type
kind                = var.kind
enable_automatic_failover = var.enable_automatic_failover

    geo_location {
        location          = var.failover_location
        }

}

// cosmosdb sql database
module "cosmosdb_sql_database" {
source              = "../../../../modules/storage/azure_cosmosdb_sql_database"

// name                = "cosmos-sqldb-${random_integer.unique.result}"
resource_group_name = var.resource_group
account_name        = var.cosmosdb_account_name
}

// cosmosdb sql container
module "cosmosdb_sql_database" {
source              = "../../../../modules/storage/azure_cosmosdb_sql_container"

// name                  = "container-${random_integer.unique.result}"
resource_group_name   = var.resource_group
account_name          = var.cosmosdb_account_name
database_name         = var.cosmosdb_sql_database_name
}

