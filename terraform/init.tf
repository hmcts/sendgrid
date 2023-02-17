terraform {
  required_version = ">= 1.2.2"
  backend "azurerm" {}
  required_providers {
    azurerm = "~> 3.11.0"
    sendgrid = {
      source  = "anna-money/sendgrid"
      version = "1.0.4"
    }
  }
}

provider "azurerm" {
  features {}
}

provider "azurerm" {
  alias = "api_key_vault"
  features {}
}

provider "sendgrid" {
  features {}
}