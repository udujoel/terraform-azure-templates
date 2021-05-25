

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

// configure DNS zone
module "dns_zone" {
source              = "../../../../modules/hosting/dns_zone"
name                = var.domain
resource_group      = var.resource_group

}

// create cname record
module "cname_record" {
source              = "../../../../modules/hosting/dns_cname_record"
resource_group      = var.resource_group
ttl                 = var.ttl
// zone_name           = var.dns_zone
// cdn_endpoint        = var.cdn_endpoint

}

