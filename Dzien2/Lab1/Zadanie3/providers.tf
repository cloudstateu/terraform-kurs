terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.44.1"
    }
  }
}

provider "azurerm" {
  # Configuration options
  features {}
  subscription_id = "__ID__TWOJEJ__SUBSKRYPCJI__"
}
