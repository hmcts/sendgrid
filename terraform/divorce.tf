locals {
  div_non_prod_domains = ["mail-divorce-nonprod.platform.hmcts.net"]
  div_prod_domains     = ["mail-divorce.platform.hmcts.net"]
}

module "divorce" {
  source      = "./modules/sendgrid"
  environment = var.environment
  account     = "divorce"
  domains     = var.environment == "prod" ? local.div_prod_domains : local.div_non_prod_domains
}

module "divorce_dns" {
  source      = "./modules/azure_dns"
  dns_records = module.divorce.dns_records
  zone_name   = "platform.hmcts.net"
}

moved {
  from = azurerm_key_vault_secret.subuser["divorce"]
  to   = module.divorce.azurerm_key_vault_secret.subuser
}

moved {
  from = azurerm_key_vault_secret.subuser-api-key["divorce"]
  to   = module.divorce.azurerm_key_vault_secret.subuser-api-key
}

moved {
  from = random_password.password["divorce"]
  to   = module.divorce.random_password.password
}

moved {
  from = sendgrid_api_key.subuser["divorce"]
  to   = module.divorce.sendgrid_api_key.subuser
}

moved {
  from = sendgrid_subuser.user["divorce"]
  to   = module.divorce.sendgrid_subuser.user
}
