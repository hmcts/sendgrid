locals {
  rd_non_prod_domains = ["mail-rd-nonprod.platform.hmcts.net"]
  rd_prod_domains     = ["mail-rd.platform.hmcts.net"]
}

module "reference_data" {
  source      = "./modules/sendgrid"
  environment = var.environment
  account     = "reference-data"
  domains     = var.environment == "prod" ? local.rd_prod_domains : local.rd_non_prod_domains
}

module "reference_data_dns" {
  source      = "./modules/azure_dns"
  dns_records = module.reference_data.dns_records
  zone_name   = "platform.hmcts.net"
}

moved {
  from = azurerm_key_vault_secret.subuser["reference-data"]
  to   = module.reference_data.azurerm_key_vault_secret.subuser
}

moved {
  from = azurerm_key_vault_secret.subuser-api-key["reference-data"]
  to   = module.reference_data.azurerm_key_vault_secret.subuser-api-key
}

moved {
  from = random_password.password["reference-data"]
  to   = module.reference_data.random_password.password
}

moved {
  from = sendgrid_api_key.subuser["reference-data"]
  to   = module.reference_data.sendgrid_api_key.subuser
}

moved {
  from = sendgrid_subuser.user["reference-data"]
  to   = module.reference_data.sendgrid_subuser.user
}
