terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "tf_backend_rg" {
  name     = "panw0011-githubactions-rg"
  location = "Canada Central"
}

resource "azurerm_storage_account" "tf_backend_sa" {
  name                     = "panw0011githubactions"
  resource_group_name      = azurerm_resource_group.tf_backend_rg.name
  location                 = azurerm_resource_group.tf_backend_rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  min_tls_version          = "TLS1_2"
}

resource "azurerm_storage_container" "tfstate" {
  name                  = "tfstate"
  storage_account_name  = azurerm_storage_account.tf_backend_sa.name
  container_access_type = "private"
}

output "resource_group_name" {
  value = azurerm_resource_group.tf_backend_rg.name
}

output "storage_account_name" {
  value = azurerm_storage_account.tf_backend_sa.name
}

output "container_name" {
  value = azurerm_storage_container.tfstate.name
}

output "arm_access_key" {
  value     = azurerm_storage_account.tf_backend_sa.primary_access_key
  sensitive = true
}
