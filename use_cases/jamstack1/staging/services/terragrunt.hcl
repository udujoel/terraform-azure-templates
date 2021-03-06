// ensure the resource group is created first
dependency "resource_group" {
  config_path = "../resource_group"
  skip_outputs    = true

}


// import/create your local variables
locals {
  env_vars        = read_terragrunt_config(find_in_parent_folders("env.hcl"))

  name            = local.env_vars.locals.name
  location        = local.env_vars.locals.location
  resource_group  = "${local.env_vars.locals.name}-RG"
  domain          = "gritty.42web.io"
}

include {
  path            = find_in_parent_folders()
}


// call your module
terraform {
  source          = ""
  
}

inputs = {
  domain          = local.domain
  resource_group  = local.resource_group
  location        = local.location
  storage_account = "${replace(local.name, "-","")}"

}