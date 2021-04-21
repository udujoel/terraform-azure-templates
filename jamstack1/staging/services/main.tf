
# Configure the Azure provider
terraform {

  backend "azurerm" {

  }
  required_providers {
    azurerm = {

      source  = "hashicorp/azurerm"
      version = "~> 2.40.0"
    }
  }
}

# provider "azurerm" {
#   features {}
# }

# module "jamstack1" {
#   source = "../../modules/services"

# }
