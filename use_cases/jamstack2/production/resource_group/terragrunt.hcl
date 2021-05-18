
locals {
  env_vars        = read_terragrunt_config(find_in_parent_folders("env.hcl"))

  name            = local.env_vars.locals.name
  location        = local.env_vars.locals.location
  resource_group  = "${local.env_vars.locals.name}-RG"
}

include {
  path            = find_in_parent_folders()
}

terraform {
  source          = "../..//modules/resource_group"
  
}

inputs = {
  location        = local.location
  resource_group  = local.resource_group
}
