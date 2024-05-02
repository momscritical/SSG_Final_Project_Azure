terraform {
  required_version = ">=1.0.0"
  required_providers {
    azapi = {
      source  = "azure/azapi"
      version = "~>1.5"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.98.0"
    }
    # aws = {
    #   source  = "hashicorp/aws"
    #   version = "~> 5.44.0"
    # }
    # random = {
    #   source  = "hashicorp/random"
    #   version = "~>3.0"
    # }
    # time = {
    #   source  = "hashicorp/time"
    #   version = "0.9.1"
    # }
  }
}

provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy    = true
      recover_soft_deleted_key_vaults = true
    }
  }
}
# provider "aws" {
#   shared_config_files      = ["~/.aws/config"] # windows : ~ , linux: $HOME
#   shared_credentials_files = ["~/.aws/credentials"]
# }
