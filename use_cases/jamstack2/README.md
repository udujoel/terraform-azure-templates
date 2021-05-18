---
title: 'Azure IAC Library documentation'
Author: Joell Udu (udujoel@Gmail.com)
---

JAMSTACK II
===

[TOC]

## Services
This template will deploy these services:
- Storage Account (Blob Storage)
- Azure CDN
- Azure DNS
- Resource Group
- App Service Web app
- App Service Plan
- Key Vault
- CosmoDB

## Prerequisites
- Azure CLI
- Azure Subscription 
- terragrunt 
- terraform 

## Architecture Diagram
![](https://i.imgur.com/QBzJpXT.png)


## Executing project
Authenticate with Azure CLI using
```bash
az login
```
then choose your account with an active Azure Subscription.

Next run the "*createstorageaccount.sh*" to provision:

- Storage Account
- Storage Account Container
- Account key

these are used for the Remote Backend on Azure.

NOTE:
***Source this to make the env variables to persist***
```bash
. ./create_storage_account.sh
```

This will export these as env variables after provisioning:

```bash=
export ARM_STORAGE_ACCOUNT_NAME=<storage-account-name>
export ARM_STORAGE_ACCOUNT_CONTAINER=<storage-account-container
export ARM_ACCESS_KEY=<storage-account-key>
```

## Managing your Infrastructure
Change Directory (*cd*) to the needed environment and use terragrunt to manage your Infrastructure as below:

```bash=
cd JAMSTACK1/staging

terragrunt run-all plan
terragrunt run-all apply

```

You can also navigate to individual resource stacks and provision:

```bash=
cd JAMSTACK1/staging/resource_group
terragrunt plan
terragrunt apply
```

When done, you can de-allocate the environment or resource:

```bash
terragrunt run-all destroy
or 
terragrunt destroy
```


## the Modules

#### Resource_group
This module requires 2 inputs when called:
- resource group name
- location
and outputes 
- the name of the created resource group
The resource_group is the first resource to be created as it holds the rest of the other resources by design. Every other resource depends on it.
#### Data_storage
This creates all backend services needed. It deployes:
- App Service Plan
- Azure Blob Storage
- CosmoDB

 This module takes 4 inputs:
- resource_group
- storage_account
- location
- failover_location
and outputs
- storage account name
- static_website_url
- cosmodb_account name
- cosmodb_sqldb name
- cosmodb_sql collection name

This module depends on the resource_group and is depended upon by the services module.
#### Services
This creates other needed services on Azure. It deploys:
- Azure Key Vault
- App service web app
- Azure CDN
- Azure DNS

It takes these inputs:
- domain name
- resource_group
- storage_account_name
- location
- service_plan_name
- sku_tier
- size_tier

and outputs
- static_website_cdn_endpoint_hostname
- static_website_cdn_profile_name

This module depends on the resource_group, and starts creation after the data-storage
