
// App Servie Plan
data "azurerm_resource_group" "resource_group" {
    name    = var.resource_group
}

resource "azurerm_app_service_plan" "app_service_plan" {
    name                = var.service_plan_name
    location            = "${data.azurerm_resource_group.resource_group.location}"
    resource_group_name = "${data.azurerm_resource_group.resource_group.name}"
    kind                = "app"

    sku {
        tier = var.sku_tier
        size = var.sku_size
    }

    tags {
        environment     = var.environment
        service         = "App Service"
        component       ="App Service Plan"
    }
}

