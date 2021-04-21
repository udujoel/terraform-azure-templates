terraform {
  backend "azurerm" {
    resource_group_name  = tstate
    storage_account_name = tstate13030
    container_name       = tstate
    key                  = var.key
  }
}

# Configure the Azure provider
provider "azurerm" {
  # The "feature" block is required for AzureRM provider 2.x. 
  # If you are using version 1.x, the "features" block is not allowed.
  version = "~>2.0"
  features {}
}

#create azure resource group
resource "azurerm_resource_group" "resource_group" {
  name     = var.resource_group
  location = var.location
}
