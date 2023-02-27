locals {
  damages_non_prod_domains = ["mail-damages-nonprod.platform.hmcts.net"]
  damages_prod_domains     = ["mail-damages.platform.hmcts.net"]
}

module "damages" {
  source      = "./modules/sendgrid"
  environment = var.environment
  account     = "damages"
  domains     = var.environment == "prod" ? local.damages_prod_domains : local.damages_non_prod_domains
}

module "damages-dns" {
  source      = "./modules/azure_dns"
  dns_records = module.damages.dns_records
  zone_name   = "platform.hmcts.net"
}

moved {
  from = azurerm_key_vault_secret.subuser["damages"]
  to   = module.damages.azurerm_key_vault_secret.subuser
}

moved {
  from = azurerm_key_vault_secret.subuser-api-key["damages"]
  to   = module.damages.azurerm_key_vault_secret.subuser-api-key
}

moved {
  from = random_password.password["damages"]
  to   = module.damages.random_password.password
}

moved {
  from = sendgrid_api_key.subuser["damages"]
  to   = module.damages.sendgrid_api_key.subuser
}

moved {
  from = sendgrid_subuser.user["damages"]
  to   = module.damages.sendgrid_subuser.user
}
