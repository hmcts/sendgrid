terraform {
  required_version = ">= 0.14.8"
  backend "azurerm" {}

  required_providers {
    azurerm = "~> 2.50.0"
    sendgrid = {
      source  = "yinzara/sendgrid"
      version = "0.2.0"
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
