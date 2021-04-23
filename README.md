---
title: "Azure IAC Library documentation"
Author: Joell Udu (udujoel@Gmail.com)
---

# Azure IaC Templates

---

Table of Contents

---

[TOC]

## Prerequisites

- Azure subscription
- [Azure Cli](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli)/Azure CloudShell
- [terraform](https://www.terraform.io/downloads.html)
- [terragrunt](https://terragrunt.gruntwork.io/docs/getting-started/install/)

## Tech-stacks

### Architecture

![](https://codimd.s3.shivering-isles.com/demo/uploads/upload_a49b1c0a13f113b7792e4e1ba40acd17.png)

## layout of files

### JAMSTACK I

📦jamstack1
┣━ 📂modules
┃ ┣━ 📂data-storage
┃ ┃ ┣━ 📜index.html
┃ ┃ ┣━ 📜main.tf
┃ ┃ ┗━ 📜var.tf
┃ ┣━ 📂network
┃ ┃ ┣━ 📜main.tf
┃ ┃ ┗━ 📜var.tf
┃ ┣━ 📂resource_group
┃ ┃ ┣━ 📜main.tf
┃ ┃ ┣━ 📜output.tf
┃ ┃ ┗━ 📜vars.tf
┃ ┗━ 📂services
┃ ┃ ┣━ 📜main.tf
┃ ┃ ┣━ 📜outputs.tf
┃ ┃ ┗━ 📜vars.tf
┣━ 📂production
┃ ┣━ 📂data-storage
┃ ┣━ 📂network
┃ ┣━ 📂services
┃ ┃ ┣━ 📜main.tf
┃ ┃ ┣━ 📜outputs.tf
┃ ┃ ┗━ 📜vars.tf
┃ ┗━ 📜env.hcl
┣━ 📂staging
┃ ┣━ 📂data-storage
┃ ┣━ 📂network
┃ ┣━ 📂resource_group
┃ ┣━ 📂services
┃ ┃ ┗━ 📜terragrunt.hcl
┃ ┗━ 📜env.hcl
┣━ 📜create_storage_account.sh
┣━ 📜shared.hcl
┗━ 📜terragrunt.hcl

## sharing variables

Use the shared.hcl and env.hcl to share variables between environments for consistency.

```gherkin=
#shared.hcl
locals {
    org_name        =    ""
    dept_prefix     =    ""
    location        =    ""
}

```

```gherkin=
#env.hcl
locals {
  shared_vars = read_terragrunt_config(find_in_parent_folders("shared.hcl"))

  name   = "${local.shared_vars.locals.name}-staging"
  location = local.shared_vars.locals.location
}
```

## Configure storage account

First [authenticate with Azure CLI](https://docs.microsoft.com/en-us/azure/developer/terraform/get-started-cloud-shell#authenticate-via-microsoft-account) using:

```bash
az login
```

Next run the "_createstorageaccount.sh_" to provision:

- Storage Account
- Storage Account Container
- Account key

Source this to make the env variables to persist

```bash
. ./create_storage_account.sh
```

Export as env variables:

```bash
export ARM_STORAGE_ACCOUNT_NAME=<storage-account-name>
export ARM_STORAGE_ACCOUNT_CONTAINER=<storage-account-container
export ARM_ACCESS_KEY=<storage-account-key>
```

## Terraform|Terragrunt Init, Plan, Apply, Destroy

Terragunt by Gruntwork.io is a thin wrapper around Terraform that fills the cracks where terraform overlooks.

Below are equivalent commands and more:

| Terraform       | Terragrunt               | outcome                                      |
| --------------- | ------------------------ | -------------------------------------------- |
| terraform init  | auto                     | downloads and initializes tf providers       |
| terraform plan  | terragrunt plan          | view effect of current IaC definition        |
|                 | terragrunt run-all plan  | execute _terragrunt plan_ on all sub folders |
| terraform apply | terragrunt apply         | execute the actions defined by IaC           |
|                 | terragrunt run-all apply | execute _terragrun apply_ on all sub folders |

## why use Terragrunt in Azure

### [Encryption at rest](https://docs.microsoft.com/en-us/azure/developer/terraform/store-state-in-azure-storage#encryption-at-rest)

Data stored in an Azure blob is encrypted before being persisted. When needed, Terraform retrieves the state from the back end and stores it in local memory. Using this pattern, state is never written to your local disk.

### [State locking](https://docs.microsoft.com/en-us/azure/developer/terraform/store-state-in-azure-storage#state-locking)

Azure Storage blobs are automatically locked before any operation that writes state. This pattern prevents concurrent state operations, which can cause corruption.

---
