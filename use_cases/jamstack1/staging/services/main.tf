

//=====================================================================================================================
// Azure CDN
//=====================================================================================================================
// create cdn profile
module "cdn_profile" {
source              = "../../../../modules/hosting/cdn_profile"
name                = var.profile_name
location            = var.location
resource_group      = var.resource_group
sku                 = var.sku

}

// create cdn endpoint
module "cdn_endpoint" {
source              = "../../../../modules/hosting/cdn_endpoint"
location            = var.location
resource_group      = var.resource_group
profile_name        = var.profile_name
storage_account     = var.storage_account

}

//=====================================================================================================================
// Azure DNS
//=====================================================================================================================

// configure Custom domain
module "custom_domain" {
source              = "../../../../modules/hosting/custom_domain"
name                = var.domain
resource_group      = var.resource_group

}

// create cname record
module "cname_record" {
source              = "../../../../modules/hosting/dns_cname_record"
resource_group      = var.resource_group
zone_name           = var.dns_zone
ttl                 = var.ttl
cdn_endpoint        = var.cdn_endpoint

}

