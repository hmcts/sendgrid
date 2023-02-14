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
  for_each = { for user in var.accounts : user.name => user }

  length           = 16
  special          = true
  min_numeric      = 1
  override_special = "_%@"
}

resource "azurerm_key_vault_secret" "subuser" {
  provider = azurerm.api_key_vault
  for_each = { for user in var.accounts : user.name => user }


  name         = "hmcts-${each.value.name}-password"
  value        = random_password.password[each.value.name].result
  key_vault_id = data.azurerm_key_vault.kv.id
  content_type = "secret"
}


resource "azurerm_key_vault_secret" "subuser-api-key" {
  provider = azurerm.api_key_vault
  for_each = { for user in var.accounts : user.name => user }

  name         = "hmcts-${each.value.name}-api-key"
  value        = sendgrid_api_key.subuser[each.value.name].api_key
  key_vault_id = data.azurerm_key_vault.kv.id
  content_type = "secret"
}


resource "sendgrid_subuser" "user" {
  provider = sendgrid
  for_each = { for user in var.accounts : user.name => user }

  username = "hmcts-${each.value.name}-${var.environment}"
  email    = "DTSPlatformOps@HMCTS.NET"
  password = random_password.password[each.value.name].result
  ips      = lookup(each.value, "ips", local.sendgrid_config[var.environment].ips)
}

resource "sendgrid_api_key" "subuser" {
  provider = sendgrid
  for_each = { for user in var.accounts : user.name => user }

  name   = "${each.value.name}-application"
  scopes = ["2fa_required", "mail.send", "sender_verification_eligible"]
}

resource "sendgrid_domain_authentication" "domain-authenticate" {
  for_each           = { for domain in var.domains : domain.name => domain }
  domain             = each.value.name
  is_default         = true
  automatic_security = false
}
