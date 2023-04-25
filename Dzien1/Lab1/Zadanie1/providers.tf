terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.40.0"
    }
  }
}

provider "azurerm" {
  # Configuration options
  subscription_id = "__ID__TWOJEJ__SUBSKRYPCJI__"
  features {}
}
