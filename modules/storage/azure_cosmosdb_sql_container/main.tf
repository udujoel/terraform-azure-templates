//=====================================================================================================================
// Azure CosmoDB SQL Container
//=====================================================================================================================

// genrate random unique number for cosmodb account name
resource "random_integer" "unique" {
  min = 10000
  max = 99999
}

// Cosmodb collection
resource "azurerm_cosmosdb_sql_container" "container" {
  name                  = "container-${random_integer.unique.result}"
  resource_group_name   = var.resource_group
  account_name          = var.cosmosdb_account_name
  database_name         = var.cosmosdb_sql_database_name
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