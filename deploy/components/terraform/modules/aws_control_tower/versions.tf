
terraform {
  required_version = ">= 1.9.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.85"
    }
  }
}

provider "aws" {
  region = var.region
}