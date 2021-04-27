dependency "resource_group" {
  config_path = "../resource_group"
}



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

terraform {
  source          = "../../modules/services"
  
}

inputs = {
  domain          = local.domain
  resource_group  = local.resource_group
  location        = local.location
  storage_account = "${replace(local.name, "-","")}"

}