locals {
  civil_non_prod_domains = ["mail-civil-nonprod.platform.hmcts.net"]
  civil_prod_domains     = ["mail-civil-prod.platform.hmcts.net"]
}

module "civil" {
  source      = "./modules/sendgrid"
  environment = var.environment
  account     = "civil"
  domains     = var.environment == "prod" ? local.civil_prod_domains : local.civil_non_prod_domains
}

module "civil-dns" {
  source      = "./modules/azure_dns"
  dns_records = module.civil.dns_records
  zone_name   = "platform.hmcts.net"
}

moved {
  from = azurerm_key_vault_secret.subuser["civil"]
  to   = module.civil.azurerm_key_vault_secret.subuser
}

moved {
  from = azurerm_key_vault_secret.subuser-api-key["civil"]
  to   = module.civil.azurerm_key_vault_secret.subuser-api-key
}

moved {
  from = random_password.password["civil"]
  to   = module.civil.random_password.password
}

moved {
  from = sendgrid_api_key.subuser["civil"]
  to   = module.civil.sendgrid_api_key.subuser
}

moved {
  from = sendgrid_subuser.user["civil"]
  to   = module.civil.sendgrid_subuser.user
}
