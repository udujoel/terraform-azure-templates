//=====================================================================================================================
// Azure CosmoDB Account
//=====================================================================================================================

// genrate random unique number for cosmodb account name
resource "random_integer" "unique" {
  min = 10000
  max = 99999
}

resource "azurerm_cosmosdb_account" "db" {
  name                = "${var.name_prefix}-${random_integer.unique.result}"
  location            = var.location
  resource_group_name = var.resource_group
  offer_type          = var.offer_type
  kind                = var.kind

  enable_automatic_failover = var.enable_automatic_failover

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
    max_interval_in_seconds = 600
    max_staleness_prefix    = 100000
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
