terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.40.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
    subscription_id = "b82ba90e-f032-4013-8090-e31e88e71ed8"
  features {}
}