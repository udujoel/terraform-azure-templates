//=============================================================================
// set environment-specific variables here
//=============================================================================
locals {
  shared_vars = read_terragrunt_config(find_in_parent_folders("shared.hcl"))
  name   = "${local.shared_vars.locals.name}-production"
  location = local.shared_vars.locals.location
}