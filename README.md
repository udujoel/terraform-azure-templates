---
title: 'Azure IAC Library documentation'
Author: Joell Udu (udujoel@Gmail.com)
---

Azure IaC Templates
===



---
Table of Contents 

---
[TOC]

## Prerequisites
* Azure subscription
* [Azure Cli](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli)/Azure CloudShell
* [terraform](https://www.terraform.io/downloads.html)
* [terragrunt](https://terragrunt.gruntwork.io/docs/getting-started/install/)


## Tech-stacks


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


## Configure storage account

First [authenticate with Azure CLI](https://docs.microsoft.com/en-us/azure/developer/terraform/get-started-cloud-shell#authenticate-via-microsoft-account) using:
```bash
az login
```

Next run the "*createstorageaccount.sh*" to provision:

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


## why use Terragrunt in Azure
### [Encryption at rest](https://docs.microsoft.com/en-us/azure/developer/terraform/store-state-in-azure-storage#encryption-at-rest)
Data stored in an Azure blob is encrypted before being persisted. When needed, Terraform retrieves the state from the back end and stores it in local memory. Using this pattern, state is never written to your local disk.

### [State locking](https://docs.microsoft.com/en-us/azure/developer/terraform/store-state-in-azure-storage#state-locking)
Azure Storage blobs are automatically locked before any operation that writes state. This pattern prevents concurrent state operations, which can cause corruption.

---



