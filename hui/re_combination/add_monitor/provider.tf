terraform {
    required_version = ">=1.8.0"
    required_providers {
        azurerm = {
            source  = "hashicorp/azurerm"
            version = "~> 3.103.0"
        }
        azapi = {
            source = "azure/azapi"
            version = "~> 1.13.1"
        }
    }
}

provider "azurerm" {
    features {}
}
provider "azapi" {
}