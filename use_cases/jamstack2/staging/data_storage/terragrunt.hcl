dependency "resource_group" {
  config_path = "../resource_group"
  skip_outputs    = true
}

locals {
  env_vars        = read_terragrunt_config(find_in_parent_folders("env.hcl"))

  name            = local.env_vars.locals.name
  location        = local.env_vars.locals.location
  resource_group  = "${local.env_vars.locals.name}-RG"
  failover_location = local.env_vars.locals.shared_vars.locals.failover_location
}

include {
  path            = find_in_parent_folders()
}

terraform {
  source          = ""
  
}

inputs = {
  location            = local.location
  resource_group      = local.resource_group
  storage_account     = "${replace(local.name, "-","")}"
  name_prefix         = local.name  
  failover_location   = local.failover_location
  # cosmosdb_account_name = local
  # cosmosdb_sql_database_name = local
}
