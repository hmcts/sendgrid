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
  version = "2.31.1"
  features {}
}

provider "azurerm" {
  version = "2.31.1"
  alias   = "api-key-vault"

  features {}
  subscription_id = local.sendgrid-key-vault[var.env].subscription
}

provider "sendgrid" {
  api_key = data.azurerm_key_vault_secret.api.value
}
