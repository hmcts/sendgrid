terraform {
  required_version = ">= 1.2.2"
  required_providers {
    azurerm = "3.58.0"
  }
}

provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
}