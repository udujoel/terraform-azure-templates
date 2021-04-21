# terraform-azure-templates

Authenticate with Azure CLI usinr
`az login`

Next run the "create_storage_account.sh" to provision:

- Storage Account
- Storage Account Container
- Account key

Source this to make the env variables to persist
`. ./create_storage_account.sh`

Export as env variables:

`export ARM_STORAGE_ACCOUNT_NAME=<storage-account-name>`
`export ARM_STORAGE_ACCOUNT_CONTAINER=<storage-account-container`
`export ARM_ACCESS_KEY=<storage-account-key>`

echo "_______________________DONE________________________________"