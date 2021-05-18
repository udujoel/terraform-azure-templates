// create random string for CDN endpoint name to avoid name conflicts
resource "random_string" "unique" {
  length  = 8
  special = false
  upper   = false
}

// Get created resource_group
data "azurerm_resource_group" "resource_group" {
    name    = var.resource_group
}

// get storage account data
data "azurerm_storage_account" "storage_account" {
  name                = var.storage_account
  resource_group_name = var.resource_group
}

// Get tenant_id, subscription_id or client_id
data "azurerm_client_config" "current" {}

//=====================================================================================================================
// Azure App Service Plan for Azure functions
//=====================================================================================================================

// App Servie Plan
resource "azurerm_app_service_plan" "app_service_plan" {
    name                = var.service_plan_name
    location            = var.location
    resource_group_name = var.resource_group
    kind                = "FunctionApp"

    sku {
        tier = var.sku_tier
        size = var.sku_size
    }

}

//=====================================================================================================================
// Azure Functions
//=====================================================================================================================

resource "azurerm_function_app" "main" {
  name                      = "${var.name}-function"
  resource_group_name       = var.resource_group
  location                  = var.location
  app_service_plan_id       = azurerm_app_service_plan.app_service_plan.id
  storage_account_name      = azurerm_storage_account.storage_account.name
  storage_account_access_key = azurerm_storage_account.storage_account.primary_access_key

  app_settings = {
    AppInsights_InstrumentationKey = azurerm_application_insights.app_insight.instrumentation_key
  }
}


//=====================================================================================================================
// Azure Application Insight for monitoring
//=====================================================================================================================
// Create App Insight
resource "azurerm_application_insights" "app_insight" {
  name                = "${var.name}-appinsights"
  resource_group_name = var.resource_group
  location            = var.location
  application_type    = "web"
}