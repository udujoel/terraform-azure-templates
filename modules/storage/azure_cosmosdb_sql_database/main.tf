//=====================================================================================================================
// Azure CosmosDB SQL Database 
//=====================================================================================================================

// genrate random unique number for cosmodb name
resource "random_integer" "unique" {
  min = 10000
  max = 99999
}

// Cosmodb SQL database
resource "azurerm_cosmosdb_sql_database" "db" {
  name                = "cosmos-sqldb-${random_integer.unique.result}"
  resource_group_name = var.resource_group
  account_name        = var.cosmosdb_account_name
}