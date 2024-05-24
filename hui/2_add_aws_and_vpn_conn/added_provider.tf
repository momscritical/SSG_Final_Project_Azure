terraform {
    required_version = ">=1.8.0"
    required_providers {
        azurerm = {
            source  = "hashicorp/azurerm"
            version = "~> 3.103.0"
        }
        aws = {
            source  = "hashicorp/aws"
            version = "~> 5.30.0"
        }
    }
}
provider "azurerm" {
    features {}
}
provider "aws" {
    region     = var.aws_loc
    shared_config_files      = ["~/.aws/config"]
    shared_credentials_files = ["~/.aws/credentials"]
}
