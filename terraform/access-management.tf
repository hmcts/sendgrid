locals {
  am_non_prod_domains = ["mail-am-nonprod.platform.hmcts.net"]
  am_prod_domains     = ["mail-am.platform.hmcts.net"]
}

module "access_management" {
  source      = "./modules/sendgrid"
  environment = var.environment
  account     = "access-management"
  domains     = var.environment == "prod" ? local.am_prod_domains : local.am_non_prod_domains
}

module "access_management_dns" {
  source      = "./modules/azure_dns"
  dns_records = module.access_management.dns_records
  zone_name   = "platform.hmcts.net"
}

moved {
  from = azurerm_key_vault_secret.subuser["access-management"]
  to   = module.access_management.azurerm_key_vault_secret.subuser
}

moved {
  from = azurerm_key_vault_secret.subuser-api-key["access-management"]
  to   = module.access_management.azurerm_key_vault_secret.subuser-api-key
}

moved {
  from = random_password.password["access-management"]
  to   = module.access_management.random_password.password
}

moved {
  from = sendgrid_api_key.subuser["access-management"]
  to   = module.access_management.sendgrid_api_key.subuser
}

moved {
  from = sendgrid_subuser.user["access-management"]
  to   = module.access_management.sendgrid_subuser.user
}
