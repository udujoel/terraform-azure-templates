
# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {

      source  = "hashicorp/azurerm"
      version = "~> 2.12"
    }
  }
}

provider "azurerm" {
  features {}
}

module "jamstack1" {
  source = "../../modules/services"

}
