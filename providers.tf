terraform {
  #backend "azurerm" {
  #      resource_group_name  = "<storage account rg name>"
  #      storage_account_name = "<azure storage account name>"
  #      container_name       = "<blob container name>"
  #      key                  = "<name of the terraform state file, for example jenkins.terraform.tfstate>"
  #
  #  set the Storage Account Access Key (ARM_ACCESS_KEY) as an environment variable = ARM_ACCESS_KEY="<storage account access key value>"
  #  }
    
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "~>3.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~>3.0"
    }
    tls = {
      source = "hashicorp/tls"
      version = "~>4.0"
    }
    cloudflare = {
      source = "cloudflare/cloudflare"
      version = "~>3.0"
    }
  }
}

provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
    key_vault {
      purge_soft_delete_on_destroy       = true
      purge_soft_deleted_keys_on_destroy = true
    }
  }
}

provider "random" {}
provider "tls" {}
provider "cloudflare" {}