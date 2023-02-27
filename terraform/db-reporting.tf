locals {
  db_non_prod_domains = ["mail-db-reporting-nonprod.platform.hmcts.net"]
  db_prod_domains     = ["mail-db-reporting-prod.platform.hmcts.net"]
}

module "db_reporting" {
  source      = "./modules/sendgrid"
  environment = var.environment
  account     = "db-reporting"
  domains     = var.environment == "prod" ? local.db_prod_domains : local.db_non_prod_domains
}

module "db_reporting_dns" {
  source      = "./modules/azure_dns"
  dns_records = module.db_reporting.dns_records
  zone_name   = "platform.hmcts.net"
}

moved {
  from = azurerm_key_vault_secret.subuser["db-reporting"]
  to   = module.db_reporting.azurerm_key_vault_secret.subuser
}

moved {
  from = azurerm_key_vault_secret.subuser-api-key["db-reporting"]
  to   = module.db_reporting.azurerm_key_vault_secret.subuser-api-key
}

moved {
  from = random_password.password["db-reporting"]
  to   = module.db_reporting.random_password.password
}

moved {
  from = sendgrid_api_key.subuser["db-reporting"]
  to   = module.db_reporting.sendgrid_api_key.subuser
}

moved {
  from = sendgrid_subuser.user["db-reporting"]
  to   = module.db_reporting.sendgrid_subuser.user
}
