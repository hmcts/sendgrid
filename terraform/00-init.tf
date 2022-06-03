terraform {
  required_version = ">= 0.14.8"
  backend "azurerm" {}

  required_providers {
    azurerm = "~> 3.9.0"
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
  alias = "api_key_vault"

  features {}
  subscription_id = local.sendgrid_config[var.environment].key_vault_subscription
}

provider "sendgrid" {
  api_key = data.azurerm_key_vault_secret.api.value
}
