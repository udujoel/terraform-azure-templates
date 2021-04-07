
#create azure resource group
resource "azurerm_resource_group" "test" {
    name = "tfResourceGroup"
    location = "westus2"
}