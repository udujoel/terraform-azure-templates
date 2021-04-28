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


// App Servie Plan
resource "azurerm_app_service_plan" "app_service_plan" {
    name                = var.service_plan_name
    location            = var.location
    resource_group_name = var.resource_group
    kind                = "app"

    sku {
        tier = var.sku_tier
        size = var.sku_size
    }

}

// Azure App Service Web
resource "azurerm_app_service" "app_service" {
  name                = "${var.name}-appservice"
  location            = var.location
  resource_group_name = var.resource_group
  app_service_plan_id = azurerm_app_service_plan.app_service_plan.id
}



// Azure CDN
// 1. create cdn profile
resource "azurerm_cdn_profile" "cdn_profile" {
  name                = "cdn-profile"
  location            = var.location
  resource_group_name = var.resource_group
  sku                 = "Standard_Microsoft"
}


// 2. create cdn endpoint
resource "azurerm_cdn_endpoint" "cdn_endpoint" {
  name                = random_string.unique.result
  profile_name        = azurerm_cdn_profile.cdn_profile.name
  location            = var.location
  resource_group_name = var.resource_group
  origin_host_header  = data.azurerm_storage_account.storage_account.primary_web_host

  origin {
    name      = "endpoint"
    host_name = data.azurerm_storage_account.storage_account.primary_web_host
  }

  delivery_rule {
    name  = "EnforceHTTPS"
    order = "1"

    request_scheme_condition {
      operator     = "Equal"
      match_values = ["HTTP"]
    }

    url_redirect_action {
      redirect_type = "Found"
      protocol      = "Https"
    }
  }
}


// Azure DNS
// 1. configure Custom domain
resource "azurerm_dns_zone" "dns_zone" {
  name                = var.domain
  resource_group_name = var.resource_group
}

// 2. create cname record
resource "azurerm_dns_cname_record" "cname" {
  name                = "www"
  zone_name           = azurerm_dns_zone.dns_zone.name
  resource_group_name = var.resource_group
  ttl                 = 300
  target_resource_id  = azurerm_cdn_endpoint.cdn_endpoint.id
}

// Azure Key Vault
resource "azurerm_key_vault" "key_vault" {
  name                        = "${random_string.unique.result}-key-vault"
  location                    = var.location
  resource_group_name         = var.resource_group
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id

  sku_name = "standard"

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "create",
      "get",
    ]

    secret_permissions = [
      "set",
      "get",
      "delete",
      "purge",
      "recover"
    ]

    storage_permissions = [
      "Get",
    ]
  }
}
 