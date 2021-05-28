// app service plan
module "app_service_plan" {
source              = "../../../../modules/compute/app_service_plan"

name                = var.service_plan_name
location            = var.location
resource_group_name = var.resource_group
tier                = var.sku_tier
size                = var.sku_size
}


// app service
module "app_service" {
source              = "../../../../modules/compute/app_service"

// name                = "${var.prefix}-appservice"
location            = var.location
resource_group_name = var.resource_group
}