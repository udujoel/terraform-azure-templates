// Resource Group
module "resource_group" {
source              = "../../../../modules/general/resource_group"

location            = var.location
resource_group      = var.resource_group

}