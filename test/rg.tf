
#create azure resource group
resource "azurerm_resource_group" "tfrg" {
    name = "tfResourceGroup"
    location = "westus2"
}