locals {
  payment_non_prod_domains = ["mail-payment-nonprod.platform.hmcts.net"]
  payment_prod_domains     = ["mail-payment.platform.hmcts.net"]
}

module "payment" {
  source      = "./modules/sendgrid"
  environment = var.environment
  account     = "payment"
  domains     = var.environment == "prod" ? local.payment_prod_domains : local.payment_non_prod_domains
}

module "payment_dns" {
  source      = "./modules/azure_dns"
  dns_records = module.payment.dns_records
  zone_name   = "platform.hmcts.net"
}

moved {
  from = azurerm_key_vault_secret.subuser["payment"]
  to   = module.payment.azurerm_key_vault_secret.subuser
}

moved {
  from = azurerm_key_vault_secret.subuser-api-key["payment"]
  to   = module.payment.azurerm_key_vault_secret.subuser-api-key
}

moved {
  from = random_password.password["payment"]
  to   = module.payment.random_password.password
}

moved {
  from = sendgrid_api_key.subuser["payment"]
  to   = module.payment.sendgrid_api_key.subuser
}

moved {
  from = sendgrid_subuser.user["payment"]
  to   = module.payment.sendgrid_subuser.user
}
