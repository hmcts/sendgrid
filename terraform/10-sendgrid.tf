data "azurerm_client_config" "current" {}

/*
resource "azurerm_resource_group" "rg" {
  name     = "${"SendGrid-"}${var.env}"
  location = "uksouth"
}
*/

data "azurerm_resource_group" "sendgrid" {
  name = "Sendgrid-${var.env}"
}


data "azurerm_key_vault" "kv" {
  provider = azurerm.api-key-vault

  name = "sendgrid${var.env}"
  resource_group_name = "SendGrid-${var.env}"
}

data "azurerm_key_vault_secret" "api" {
  name = "platform-operations-api-key"
  key_vault_id = data.azurerm_key_vault.kv.id  
}



resource "random_password" "password" {
  for_each = { for user in var.subusers : user.username => user }

  length           = 16
  special          = true
  min_numeric      = 1
  override_special = "_%@"
}

resource "azurerm_key_vault_secret" "subuser" {
  for_each = { for user in var.subusers : user.username => user}

  name         = "${each.value.username}-password"
  value        = random_password.password[each.value.username].result
  key_vault_id = data.azurerm_key_vault.kv.id
}


resource "azurerm_key_vault_secret" "subuser-api-key" {
  for_each = { for user in var.subusers : user.username => user}

  name         = "${each.value.username}-api-key"
  value        = sendgrid_api_key.subuser[each.value.username].api_key
  key_vault_id = data.azurerm_key_vault.kv.id
}


resource "sendgrid_subuser" "user" {
  provider = sendgrid
  for_each = { for user in var.subusers : user.username => user}

  username = each.value.username
  email = each.value.email
  password = random_password.password[each.value.username].result
  ips = each.value.ips
}

resource "sendgrid_api_key" "subuser" {
  provider = sendgrid
  for_each = { for user in var.subusers : user.username => user}

  name = "${each.value.username}-application"
  scopes = ["mail.send", "sender_verification_eligible"]
  sub_user_on_behalf_of = sendgrid_subuser.user[each.value.username].username
}

