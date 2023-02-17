terraform {
  required_version = ">= 1.2.2"
  backend "azurerm" {}
  required_providers {
    azurerm = "~> 3.11.0"
    sendgrid2 = {
      source  = "anna-money/sendgrid"
      version = "1.0.4"
    }
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

data "azurerm_key_vault" "kv" {
  provider = azurerm.api_key_vault

  name                = "sendgrid${var.environment}"
  resource_group_name = "SendGrid-${var.environment}"
}

data "azurerm_key_vault_secret" "api" {
  provider = azurerm.api_key_vault

  name         = "platform-operations-api-key"
  key_vault_id = data.azurerm_key_vault.kv.id
}

provider "sendgrid" {
  api_key = data.azurerm_key_vault_secret.api.value
}