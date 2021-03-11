terraform {
  required_version = ">= 0.12.25"
  backend "azurerm" {}

  required_providers {
    azurerm = "~> 2.31.1"
    sendgrid = {
      source  = "Trois-Six/sendgrid"
      version = "0.1.6"
    }
  }
}

provider "azurerm" {
  features {}
}

provider "azurerm" {
  alias   = "api_key_vault"

  features {}
  subscription_id = local.sendgrid_key_vault[var.env].subscription
}

provider "sendgrid" {
  api_key = data.azurerm_key_vault_secret.api.value
}
