terraform {
    required_version = ">=1.0.0"
    required_providers {
        aws = {
            source  = "hashicorp/aws"
            version = "~> 5.44.0"
        }
    }
}

provider "aws" {
    region     = var.aws_loc
    shared_config_files      = ["~/.aws/config"]
    shared_credentials_files = ["~/.aws/credentials"]
}
