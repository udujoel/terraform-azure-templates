---
title: 'Azure IAC Library documentation'
Author: Joell Udu (udujoel@Gmail.com)
---

JAMSTACK I
===

[TOC]

## Services
This template will deploy these services:
- Storage Account (Blob Storage)
- Azure CDN
- Azure DNS
- Resource Group

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

Next run the "*createstorageaccount.sh*" to provision:

- Storage Account
- Storage Account Container
- Account key

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



