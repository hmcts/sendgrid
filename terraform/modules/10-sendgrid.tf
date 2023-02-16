data "azurerm_client_config" "current" {}

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

resource "random_password" "password" {
  length           = 16
  special          = true
  min_numeric      = 1
  override_special = "_%@"
}

resource "azurerm_key_vault_secret" "subuser" {
  provider = azurerm.api_key_vault

  name         = "hmcts-${var.account}-password"
  value        = random_password.password.result
  key_vault_id = data.azurerm_key_vault.kv.id
}


resource "azurerm_key_vault_secret" "subuser-api-key" {
  provider     = azurerm.api_key_vault
  name         = "hmcts-${var.account}-api-key"
  value        = sendgrid_api_key.subuser.api_key
  key_vault_id = data.azurerm_key_vault.kv.id
}


resource "sendgrid_subuser" "user" {
  provider = sendgrid

  username = "hmcts-${var.account}-${var.environment}"
  email    = "DTSPlatformOps@HMCTS.NET"
  password = random_password.password.result
  ips      = local.sendgrid_config[var.environment].ips

}

resource "sendgrid_api_key" "subuser" {
  provider = sendgrid

  name   = "${var.account}-application"
  scopes = ["mail.send", "2fa_required", "sender_verification_eligible"]
}

resource "sendgrid_domain_authentication" "domain-authenticate" {
  for_each            = toset(var.domains)
  provider           = sendgrid.subuser
  domain             = each.key
  is_default         = true
  automatic_security = false
}