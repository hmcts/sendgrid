locals {
  et_non_prod_domains = ["employmenttribunals-nonprod.service.gov.uk"]
  et_prod_domains     = ["employmenttribunals.service.gov.uk"]
}

module "employment_tribunals" {
  source      = "./modules/sendgrid"
  environment = var.environment
  account     = "employment-tribunals"
  domains     = var.environment == "prod" ? local.et_prod_domains : local.et_non_prod_domains
}

module "employment_tribunals_dns" {
  source      = "./modules/azure_dns"
  dns_records = module.employment_tribunals.dns_records
  zone_name   = "tribunalsdecisions.service.gov.uk"
}

moved {
  from = azurerm_key_vault_secret.subuser["employment-tribunals"]
  to   = module.employment_tribunals.azurerm_key_vault_secret.subuser
}

moved {
  from = azurerm_key_vault_secret.subuser-api-key["employment-tribunals"]
  to   = module.employment_tribunals.azurerm_key_vault_secret.subuser-api-key
}

moved {
  from = random_password.password["employment-tribunals"]
  to   = module.employment_tribunals.random_password.password
}

moved {
  from = sendgrid_api_key.subuser["employment-tribunals"]
  to   = module.employment_tribunals.sendgrid_api_key.subuser
}

moved {
  from = sendgrid_subuser.user["employment-tribunals"]
  to   = module.employment_tribunals.sendgrid_subuser.user
}
