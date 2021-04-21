locals {
  env_vars        = read_terragrunt_config(find_in_parent_folders("env.hcl"))

  name            = local.env_vars.locals.name
  location        = local.env_vars.locals.location
  resource_group  = "terraform-rg"
}

include {
  path            = find_in_parent_folders()
}

terraform {
  source          = "../../modules/resource_group"
  
}

inputs = {
  name            = local.name
  location        = local.location
  resource_group  = local.resource_group
}




















// terraform {
//   backend "azurerm" {
//     resource_group_name  = "tstate"
//     storage_account_name = "tstate13030"
//     container_name       = "tstate"
//     key                  = "terraform.tfstate"
//   }


//   # Configure the Azure provider
//   required_providers {
//     azurerm = {

//       source  = "hashicorp/azurerm"
//       version = "~> 2.40.0"
//     }
//   }
// }
// # # Configure the Azure provider
// # provider "azurerm" {
// #   # The "feature" block is required for AzureRM provider 2.x. 
// #   # If you are using version 1.x, the "features" block is not allowed.
// #   version = "~>2.0"
// #   features {}
// # }

// #create azure resource group
// resource "azurerm_resource_group" "resource_group" {
//   name     = var.resource_group
//   location = var.location
// }
