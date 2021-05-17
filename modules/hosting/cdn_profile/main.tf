
//=====================================================================================================================
// Azure CDN Profile
//=====================================================================================================================
// create cdn profile
resource "azurerm_cdn_profile" "cdn_profile" {
  name                = var.profile_name
  location            = var.location
  resource_group_name = var.resource_group
  sku                 = var.sku
}
