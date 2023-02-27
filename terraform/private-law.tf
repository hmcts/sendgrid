locals {
  prl_non_prod_domains = ["mail-prl-nonprod.aat.platform.hmcts.net", "mail-prl-nonprod.demo.platform.hmcts.net", "mail-prl-nonprod.ithc.platform.hmcts.net", "mail-prl-nonprod.perftest.platform.hmcts.net", "mail-prl-nonprod.preview.platform.hmcts.net"]
  prl_prod_domains     = ["mail-prl.platform.hmcts.net"]
}

module "private_law" {
  source      = "./modules/sendgrid"
  environment = var.environment
  account     = "private-law"
  domains     = var.environment == "prod" ? local.prl_prod_domains : local.prl_non_prod_domains
}

module "private_law_dns" {
  source      = "./modules/azure_dns"
  dns_records = module.private_law.dns_records
  zone_name   = "platform.hmcts.net"
}

moved {
  from = azurerm_key_vault_secret.subuser["private-law"]
  to   = module.private_law.azurerm_key_vault_secret.subuser
}

moved {
  from = azurerm_key_vault_secret.subuser-api-key["private-law"]
  to   = module.private_law.azurerm_key_vault_secret.subuser-api-key
}

moved {
  from = random_password.password["private-law"]
  to   = module.private_law.random_password.password
}

moved {
  from = sendgrid_api_key.subuser["private-law"]
  to   = module.private_law.sendgrid_api_key.subuser
}

moved {
  from = sendgrid_subuser.user["private-law"]
  to   = module.private_law.sendgrid_subuser.user
}
