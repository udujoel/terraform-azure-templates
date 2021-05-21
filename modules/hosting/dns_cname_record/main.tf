
//=====================================================================================================================
// Azure DNS CNAME Record
//=====================================================================================================================

// get cdn_endpoint data
data "azurerm_cdn_endpoint" "cdn_endpoint" {
  name                = var.cdn_endpoint
  resource_group_name = var.resource_group
}

// create cname record
resource "azurerm_dns_cname_record" "cname" {
  name                = "www"
  zone_name           = var.dns_zone
  resource_group_name = var.resource_group
  ttl                 = var.ttl
  target_resource_id  = data.azurerm_cdn_endpoint.cdn_endpoint.id
}