
//=====================================================================================================================
// Azure DNS CNAME Record
//=====================================================================================================================

// get cdn_endpoint data
data "azurerm_cdn_endpoint" "cdn_endpoint" {
  name                = module.cdn_endpoint.cdn_endpoint_name
  resource_group_name = var.resource_group
}

// get DNS_zone data
data "azurerm_dns_zone" "dns_zone" {
  name                = var.domain
  resource_group_name = var.resource_group
}



// create cname record
resource "azurerm_dns_cname_record" "cname" {
  name                = "www"
  zone_name           = data.azure_dns_zone.dns_zone.name
  resource_group_name = var.resource_group
  ttl                 = var.ttl
  target_resource_id  = data.azurerm_cdn_endpoint.cdn_endpoint.id
}