// genrate random unique number for cosmodb account name
resource "random_integer" "unique" {
  min = 10000
  max = 99999
}

//=====================================================================================================================
// Azure Blob Storage
//=====================================================================================================================
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


//=====================================================================================================================
// Azure CosmoDB
//=====================================================================================================================
// Azure CosmoDB account
resource "azurerm_cosmosdb_account" "db" {
  name                = "tfex-cosmos-db-${random_integer.unique.result}"
  location            = var.location
  resource_group_name = var.resource_group
  offer_type          = "Standard"
  kind                = "GlobalDocumentDB"

  enable_automatic_failover = true

  capabilities {
    name = "EnableAggregationPipeline"
  }

  capabilities {
    name = "mongoEnableDocLevelTTL"
  }

  capabilities {
    name = "MongoDBv3.4"
  }

  consistency_policy {
    consistency_level       = "BoundedStaleness"
    max_interval_in_seconds = 10
    max_staleness_prefix    = 200
  }

  geo_location {
    location          = var.failover_location
    failover_priority = 1
  }

  geo_location {
    location          = var.location
    failover_priority = 0
  }
}

// Cosmodb SQL database
resource "azurerm_cosmosdb_sql_database" "db" {
  name                = "cosmos-sqldb-${random_integer.unique.result}"
  resource_group_name = var.resource_group
  account_name        = azurerm_cosmosdb_account.db.name
}

// Cosmodb collection
resource "azurerm_cosmosdb_sql_container" "container" {
  name                  = "container-${random_integer.unique.result}"
  resource_group_name   = var.resource_group
  account_name          = azurerm_cosmosdb_account.container.name
  database_name         = azurerm_cosmosdb_sql_database.container.name
  partition_key_path    = "/definition/id"
  partition_key_version = 1
  throughput            = 400

  indexing_policy {
    indexing_mode = "Consistent"

    included_path {
      path = "/*"
    }

    included_path {
      path = "/included/?"
    }

    excluded_path {
      path = "/excluded/?"
    }
  }

  unique_key {
    paths = ["/definition/idlong", "/definition/idshort"]
  }
}