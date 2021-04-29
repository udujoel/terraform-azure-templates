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


### Architecture

![](https://codimd.s3.shivering-isles.com/demo/uploads/upload_a49b1c0a13f113b7792e4e1ba40acd17.png)

## layout of files
## Tech-stacks

### JAMSTACK I

### JAMSTACK II
### JAMSTACK III (Serverless)


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

## What is Terragrunt
Terragrunt is a thin wrapper around Terraform with the expressed intent of making your Terrform configurations and codes DRY.
## why use Terragrunt in Azure

### [Encryption at rest](https://docs.microsoft.com/en-us/azure/developer/terraform/store-state-in-azure-storage#encryption-at-rest)

Data stored in an Azure blob is encrypted before being persisted. When needed, Terraform retrieves the state from the back end and stores it in local memory. Using this pattern, state is never written to your local disk.

### [State locking](https://docs.microsoft.com/en-us/azure/developer/terraform/store-state-in-azure-storage#state-locking)

Azure Storage blobs are automatically locked before any operation that writes state. This pattern prevents concurrent state operations, which can cause corruption.

### Apply DRY principle in your IaC
With terraform, one would have to copy/paste the provider configuration in each of your Terraform modules. Terragrunt enables us to apply the DRY principle with our provider configuration. You only have to write the configuration once and be able to reuse it in the parent as well as all child modules.  Although the Provider block isn’t a lot of lines of code but can be a pain to maintain. 

In the root `terragrunt.hcl` file, you would define the provider configuration using the generate block. 

### Keeping Remote configurations DRY
Terraform backends allow you to store Terraform state in a shared location which is great for teamwork and collaboration. This can be a Blob container. Terraform provides locking around your state files to protect against race conditions.

In Terraform, however, you have to copy/paste the same backend configuration into every one of your Terraform modules. To Resolve this issue terragrunt come up with a great feature where you will write backend configuration once and use it multiple times.


Terragrunt also helps Execute Terraform commands on multiple modules at once.
```bash=
terragrunt run-all init
terragrunt run-all plan
terragrunt run-all output
terragrunt run-all apply
terragrunt run-all destroy

```
---
## REFERENCE DOCUMENT


## **Infrastructure Deployment Strategies (Azure)**


<table>
  <tr>
   <td colspan="3" >
<h2><strong>Deployment Strategies</strong></h2>


   </td>
   <td>
   </td>
  </tr>
  <tr>
   <td>
   </td>
   <td><strong>Architecture</strong>
   </td>
   <td><strong>Azure Services</strong>
   </td>
   <td><strong>AWS Services</strong>
   </td>
  </tr>
  <tr>
   <td><p style="text-align: right">
1</p>

   </td>
   <td>
<h3><strong>JAMSTACK I</strong></h3>


   </td>
   <td>
<ul>

<li>Storage Account (Blob Storage)

<li>Azure CDN

<li>Azure DNS

<li>Resource Group
</li>
</ul>
   </td>
   <td>
<ul>

<li>S3 

<li>CloudFront 

<li>Route 53 

<li>ACM
</li>
</ul>
   </td>
  </tr>
  <tr>
   <td><p style="text-align: right">
2</p>

   </td>
   <td>
<h3><strong>JAMSTACK (Azure App Service)II</strong></h3>


   </td>
   <td>
<ul>

<li>App Service Plan

<li>App Service Web App

<li>Azure Blob Storage

<li>Azure CDN

<li>Azure DNS

<li>SQL/CosmoDB

<li>Azure Key Vault

<li>Resource Group
</li>
</ul>
   </td>
   <td>
<ul>

<li>S3 

<li>CloudFront 

<li>Route 53 

<li>ACM 

<li>API Gateway 

<li>LAMBDA
</li>
</ul>
   </td>
  </tr>
  <tr>
   <td><p style="text-align: right">
3</p>

   </td>
   <td>
<h3><strong>JAMSTACK (Serverless) III</strong></h3>


   </td>
   <td>
<ul>

<li>Azure Functions

<li>CosmoDB/SQL 

<li>Azure CDN 

<li>Azure API Management Services

<li>Resource group
</li>
</ul>
   </td>
   <td>
<ul>

<li>S3 

<li>CloudFront 

<li>Route 53 

<li>ACM 

<li>API Gateway 

<li>LAMBDA 

<li>RDS (or DynamoDB)
</li>
</ul>
   </td>
  </tr>
  <tr>
   <td><p style="text-align: right">
4</p>

   </td>
   <td>
<h3><strong>Containers (with rolling update capacity) </strong></h3>


   </td>
   <td>
<ul>

<li>Storage Account (Blob Storage)

<li>Azure CDN

<li>Azure DNS

<li>Azure Key Vault Certificate

<li>Container Instance

<li>ACR

<li>Azure CDN

<li>Azure Key Vault Certificates 

<li>Loadbalancer 

<li>CosmoDB
</li>
</ul>
   </td>
   <td>
<ul>

<li>S3 

<li>CloudFront 

<li>Route 53 

<li>ACM

<li>ECS (Fargate) 

<li>ECR 

<li>Cloudfront 

<li>ACM 

<li>Loadbalancer 

<li>RDS (or DynamoDB)
</li>
</ul>
   </td>
  </tr>
  <tr>
   <td><p style="text-align: right">
5</p>

   </td>
   <td>
<h3><strong>Containers (with rolling update capacity and high availability)</strong></h3>


   </td>
   <td>
<ul>

<li>Storage Account (Blob Storage)

<li>Azure CDN

<li>Azure DNS

<li>Azure Key Vault Certificate

<li>AKS

<li>ACR

<li>CosmoDB

<li>Loadbalancer
</li>
</ul>
   </td>
   <td>
<ul>

<li>S3 

<li>CloudFront 

<li>Route 53 

<li>ACM

<li>EKS 

<li>ECR 

<li>Cloudfront 

<li>ACM 

<li>RDS (or DynamoDB)

<li>Loadbalancer
</li>
</ul>
   </td>
  </tr>
  <tr>
   <td><p style="text-align: right">
6</p>

   </td>
   <td>
<h3><strong>VMs</strong></h3>


   </td>
   <td>
<ul>

<li>Storage Account (Blob Storage)

<li>Azure CDN

<li>Azure DNS

<li>Azure Key Vault Certificate

<li>Azure VM
</li>
</ul>
   </td>
   <td>
<ul>

<li>S3 

<li>CloudFront 

<li>Route 53 

<li>ACM

<li>EC2
</li>
</ul>
   </td>
  </tr>
  <tr>
   <td><p style="text-align: right">
7</p>

   </td>
   <td>
<h3><strong>VMs (with rolling update capacity, high availability, immutable infrastructure)</strong></h3>


   </td>
   <td>
<ul>

<li>Storage Account (Blob Storage)

<li>Azure CDN

<li>Azure DNS

<li>Azure Key Vault Certificate

<li>Azure VMSS

<li>Loadbalancer 
</li>
</ul>
   </td>
   <td>
<ul>

<li>S3 

<li>CloudFront 

<li>Route 53 

<li>ACM

<li>EC2 

<li>Autoscaling groups,

<li>Loadbalancer 

<li>AMIs
</li>
</ul>
   </td>
  </tr>
  <tr>
   <td><p style="text-align: right">
8</p>

   </td>
   <td>
<h3><strong>(Serverless) Azure App Service </strong></h3>


   </td>
   <td>
<ul>

<li>Storage Account (Blob Storage)

<li>Azure CDN

<li>Azure DNS

<li>Azure Key Vault Certificates

<li>Azure App Service

<li>CosmoDB
</li>
</ul>
   </td>
   <td>
<ul>

<li>S3 

<li>CloudFront 

<li>Route 53 

<li>ACM

<li>Elastic BeanStalk

<li>RDS (or DynamoDB)
</li>
</ul>
   </td>
  </tr>
  <tr>
   <td><p style="text-align: right">
9</p>

   </td>
   <td>
<h3><strong>De-coupled (Serverless)</strong></h3>


   </td>
   <td>
<ul>

<li>App Service Plan 

<li>Azure Functions

<li>Azure API Management Services

<li>Azure CDN 

<li>Azure DNS 

<li>Azure Service Bus 

<li>Azure Front Door/ Azure Traffic Manager
</li>
</ul>
   </td>
   <td>
<ul>

<li>S3 

<li>CloudFront 

<li>Route 53 

<li>ACM 

<li>API Gateway 

<li>LAMBDA

<li>SQS
</li>
</ul>
   </td>
  </tr>
  <tr>
   <td><p style="text-align: right">
10</p>

   </td>
   <td>
<h3><strong>De-coupled (VMs)</strong></h3>


   </td>
   <td>
<ul>

<li>Storage Account (Blob Storage)

<li>Azure CDN

<li>Azure DNS

<li>Azure Key Vault Certificates

<li>VMSS

<li>Loadbalancer 

<li>Azure Service Bus 
</li>
</ul>
   </td>
   <td>
<ul>

<li>S3

<li>CloudFront

<li>Route 53

<li>ACM

<li>EC2

<li>Autoscaling groups

<li>Loadbalancer 

<li>AMIs

<li>SQS
</li>
</ul>
   </td>
  </tr>
</table>



## Architecture diagrams

JAMSTACK (SERVERLESS):
![](https://i.imgur.com/bEuSoMF.png)


JAMSTACK (App Service Web App)
![](https://i.imgur.com/Ijkb751.png)

