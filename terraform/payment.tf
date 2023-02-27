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
  zone_name     = "platform.hmcts.net"
  depends_on = [
    module.payment
  ]
}