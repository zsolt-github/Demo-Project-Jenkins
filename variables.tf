# --- Variable for the environment -------------------------

variable "az_env_postfix" {
    type        = string
    description = "The postfix which should be used for all resources in this environment."
}

variable "az_tag_environment" {
    type        = string
    description = "The environment tag."
    default     = "Demo"
}



# --- Variables for the Azure Resource Group -------------------------

variable "az_location" {
    type        = string
    description = "Location of the resources in Azure."
    default     = "UKWest"
}

variable "az_resource_group_name" {
    type        = string
    description = "Resource Group name in Azure."
}



# --- Variables for the Azure Virtual Network -------------------------

variable "az_virtual_network_name" {
    type        = string
    description = "Name of the VLAN in Azure."
}

variable "az_virtual_network_address_space" {
    type        = string
    description = "The address space of the VLAN in Azure."
}



# --- Variables for Azure the Subnet -------------------------

variable "az_subnet_1_name" {
    type        = string
    description = "Name of Subnet 1 in Azure."
}

variable "az_subnet_1_address_prefix" {
    type        = string
    description = "The address space of Subnet 1 in Azure."
}

variable "az_subnet_2_name" {
    type        = string
    description = "Name of Subnet 2 in Azure."
}

variable "az_subnet_2_address_prefix" {
    type        = string
    description = "The address space of Subnet 2 in Azure."
}



# Variables for Azure Network Security Groups -------------------------

variable "az_nsg_1_name" {
    type        = string
    description = "Name of Azure Network Security Group 1."
}

variable "az_nsg_2_name" {
    type        = string
    description = "Name of Azure Network Security Group 2."
}



# Variables for Azure Network Interface(s) -------------------------

variable "az_net_int-1" {
    type        = string
    description = "Name of Azure Network Interface 1."
}

variable "az_net_int-2" {
    type        = string
    description = "Name of Azure Network Interface 2."
}



# Variables for the Azure Public IP(s) -------------------------

variable "az_public_ip_1_name" {
    type        = string
    description = "Name for Azure Public IP 1."
}

variable "az_public_ip_1_type" {
    type        = string
    description = "Type of Public IP 1."
}

variable "az_public_ip_1_sku" {
    type        = string
    description = "SKU of Public IP 1."
}



# Variables for the Azure Storage Account(s) -------------------------

variable "az_storage_account_1_name" {
    type        = string
    description = "Name for Storage Account 1."
}

variable "az_storage_account_1_kind" {
    type        = string
    description = "Kind of Storage Account 1. (BlobStorage, BlockBlobStorage, FileStorage, Storage and StorageV2)"
}

variable "az_storage_account_1_account_tier" {
    type        = string
    description = "Name for Storage Account 1. (Standard or Premium)"
}

variable "az_storage_account_1_replication_type" {
    type        = string
    description = "Name for Storage Account 1. (LRS, GRS, RAGRS, ZRS, GZRS and RAGZRS)"
}

variable "az_storage_account_1_acces_tier" {
    type        = string
    description = "Access tier for Storage Account 1. (Hot or Cool)"
}

variable "az_storage_account_1_min_tls_version" {
    type        = string
    description = "Minimum TLS version for Storage Account 1. (TLS1_0, TLS1_1 and TLS1_2)"
}



# Variables for the Azure Storage Container(s) -------------------------

variable "az_storage_conainer_1_name" {
    type        = string
    description = "Name for Storage Container 1. (Only lowercase letters, numbers and hyphens allowed. Max length is 3 - 63 characters.)"
}

variable "az_storage_container_1_access_type" {
    type        = string
    description = "Acces type for Storage Container 1. (blob, container or private)"
}



#Variables for Azure Virtual Machine(s) -------------------------

variable "az_windows_virtual_machine_1_name" {
    type        = string
    description = "Name of Virtual Machine 1."
}

variable "az_linux_virtual_machine_1_name" {
    type        = string
    description = "Name of Virtual Machine 1."
}

variable "az_linux_virtual_machine_1_computer_name" {
    type        = string
    description = "Computer Name of Virtual Machine 1."
}

variable "az_virtual_machine_1_size" {
    type        = string
    description = "Name of Virtual Machine 1."
}

variable "az_virtual_machine_1_admin_user_name" {
    type        = string
    description = "Name of the admin user for Virtual Machine 1."
}

variable "az_virtual_machine_1_admin_user_password" {
    type        = string
    description = "Password of the admin user for Virtual Machine 1."
    sensitive   = true
}

variable "az_linux_virtual_machine_1_public_key" {
    type        = string
    description = "Password of the admin user for Virtual Machine 1."
    sensitive   = true
}

variable "az_virtual_machine_1_storage_account_type" {
    type        = string
    description = "Storage account type for Virtual Machine 1. (Standard_LRS, StandardSSD_LRS, Premium_LRS, StandardSSD_ZRS and Premium_ZRS)"
}




# --- Variables for Jenkins -------------------------

variable "jenkins_admin_user" {
  type        = string
  description = "Admin user of the Jenkins."
  default     = "admin"
}

variable "jenkins_admin_password" {
  type        = string
  description = "Admin password of the Jenkins."
}