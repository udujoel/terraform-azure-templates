# create app service and app service plan
resource "azurerm_app_service_plan" "test" {
    name                = "testAppServicePlan"
    location            = azurerm_resource_group.test.location
    resource_group_name = azurerm_resource_group.test.name
    sku {
        tier = "Standard"
        size = "S1"
    }
}

resource "azurerm_app_service" "test" {
    name                = "testAppService"
    location            = azurerm_resource_group.test.location
    resource_group_name = azurerm_resource_group.test.name
    app_service_plan_id = azurerm_app_service_plan.test.id
}