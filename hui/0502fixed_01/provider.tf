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
  features {}
}
# provider "aws" {
#   shared_config_files      = ["~/.aws/config"]
#   shared_credentials_files = ["~/.aws/credentials"]
# }
