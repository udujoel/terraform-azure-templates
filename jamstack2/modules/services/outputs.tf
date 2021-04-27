output "CDN_endpoint"{
    value = azurerm_cdn_endpoint.cdn_endpoint.id
}
output "CDN_profile"{
    value = azurerm_cdn_profile.cdn_profile.id
}
output "app_service_name"{
    value = azurerm_app_service.app_service.name
}
output "resource_group"{
    value = azurerm_resource_group.resource_group.name
}

output "id" {
    value = azurerm_app_service_plan.app_service_plan.id
}

output "name" {
    value = azurerm_app_service_plan.app_service_plan.name
}