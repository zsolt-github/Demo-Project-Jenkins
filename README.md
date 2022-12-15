# TERRAFORM - Azure resources

This GitHub repo contains Terraform config files to build Azure resources needed to run a Jenkins server so I can learn and practice.

>Note: This is not meant for production!!!


## Providers

| Name | Version |
|------|---------|
| azure | 3.20.0 |


### Deployment Instructions
* Clone this repository
* Edit ```terraform.tfvars``` to match your values.
* Run ```terraform init``` to download the Azure provider.
* Run ```terraform plan``` to view the plan.
* Run ```terraform apply``` and wait a couple of minutes until the resources created in the Azure cloud.


## Resources used and links to the relevant Terraform websites where you can find more information about further options.

| Name | Type |
|------|------|
| [azurerm_resource_group.azure-rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_virtual_network.azure-vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network) | resource |
| [azurerm_subnet.azure-subnet-1/2](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_network_security_group.azure-nsg-1/2](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group) | resource |
| [azurerm_subnet_network_security_group_association.azure-nsg_1_association](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_network_security_group_association) | resource |
| [azurerm_network_interface.azure-net_int-1](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface) | resource |
| [azurerm_public_ip.azure-public_ip-1](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip) | resource |
| [azurerm_windows_virtual_machine.azure-windows_virtual_machine-1](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/windows_virtual_machine) | resource |
| [azurerm_storage_account.azure-storage_account-1](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account) | resource |
