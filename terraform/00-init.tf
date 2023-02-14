terraform {
  required_version = ">= 1.2.2"
  backend "azurerm" {}

  required_providers {
    azurerm = "~> 3.11.0"
    sendgrid = {
      source  = "Trois-Six/sendgrid"
      version = "0.2.1"
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
