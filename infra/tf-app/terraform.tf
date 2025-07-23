terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "panw0011-githubactions-rg"
    storage_account_name = "panw0011githubactions"
    container_name       = "tfstate"
    key                  = "prod.app.tfstate"
  }
}

provider "azurerm" {
  features {}
}
