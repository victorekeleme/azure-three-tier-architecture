terraform {
  required_version = "~> 1.3.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.62.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.5.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "terraform-statefiles-rg"
    storage_account_name = "terraformstatefilessa"
    container_name       = "statefiles"
    key                  = "terraform.tfstate"
  }
}

provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}