locals {
  cmc_non_prod_domains = ["mail-money-claims-nonprod.platform.hmcts.net"]
  cmc_prod_domains     = ["mail-money-claims-prod.platform.hmcts.net"]
}

module "cmc" {
  source      = "./modules/sendgrid"
  environment = var.environment
  account     = "cmc"
  domains     = var.environment == "prod" ? local.cmc_prod_domains : local.cmc_non_prod_domains
}

module "cmc_dns" {
  source      = "./modules/azure_dns"
  dns_records = module.cmc.dns_records
  zone_name   = "platform.hmcts.net"
}

moved {
  from = azurerm_key_vault_secret.subuser["cmc"]
  to   = module.cmc.azurerm_key_vault_secret.subuser
}

moved {
  from = azurerm_key_vault_secret.subuser-api-key["cmc"]
  to   = module.cmc.azurerm_key_vault_secret.subuser-api-key
}

moved {
  from = random_password.password["cmc"]
  to   = module.cmc.random_password.password
}

moved {
  from = sendgrid_api_key.subuser["cmc"]
  to   = module.cmc.sendgrid_api_key.subuser
}

moved {
  from = sendgrid_subuser.user["cmc"]
  to   = module.cmc.sendgrid_subuser.user
}
