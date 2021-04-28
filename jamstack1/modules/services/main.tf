

// create a random string for CDN endpoint name to avoid name conflicts
resource "random_string" "unique" {
  length  = 8
  special = false
  upper   = false
}

// get storage account data
data "azurerm_storage_account" "storage_account" {
  name                = var.storage_account
  resource_group_name = var.resource_group
}

//=====================================================================================================================
// Azure CDN
//=====================================================================================================================
// create cdn profile
resource "azurerm_cdn_profile" "cdn_profile" {
  name                = "cdn-profile"
  location            = var.location
  resource_group_name = var.resource_group
  sku                 = "Standard_Microsoft"
}


// create cdn endpoint
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

//=====================================================================================================================
// Azure DNS
//=====================================================================================================================

// configure Custom domain
resource "azurerm_dns_zone" "dns_zone" {
  name                = var.domain
  resource_group_name = var.resource_group
}

// create cname record
resource "azurerm_dns_cname_record" "cname" {
  name                = "www"
  zone_name           = azurerm_dns_zone.dns_zone.name
  resource_group_name = var.resource_group
  ttl                 = 300
  target_resource_id  = azurerm_cdn_endpoint.cdn_endpoint.id
}