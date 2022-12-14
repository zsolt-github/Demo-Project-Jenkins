# DEMO Project

This GitHub repo contains my first demo project. This project uses Terraform to build resources in the Azure cloud.

>Note: This is not meant for production!!!


## Providers

| Name | Version |
|------|---------|
| Azure | 3.20.0 |
| Kubernetes | 2.13.1 |
| Helm | 2.6.0 |


### Deployment Instructions
* Clone this repository
* Edit ```terraform.tfvars``` to match your values.
* Run ```terraform init``` to download the Azure provider.
* Run ```terraform plan``` to view the plan.
* Run ```terraform apply``` and wait a couple of minutes until the resources created in the Azure cloud.


## Resources used and links to the relevant Terraform websites where you can find more information about further options.

| Name and link to the Terraform website | Resource Type |
|------|------|
| [azurerm_resource_group.azure-rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | Resource Group |
| [azurerm_virtual_network.azure-vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network) | Virtual Network |
| [azurerm_subnet.azure-subnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | Subnet |
| [azurerm_kubernetes_cluster.aks](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster) | Kubernetes Services |
| [azurerm_role_assignment.role_acrpull](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | Role Assignemt |
| [azurerm_container_registry.acr](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry) | Container Registry |

