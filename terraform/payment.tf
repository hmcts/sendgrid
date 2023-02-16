locals {
  pa_non_prod_domains = ["mail-payment-nonprod.platform.hmcts.net"]
  pa_prod_domains     = ["mail-payment.platform.hmcts.net"]
}

module "payment" {
  source      = "./modules"
  environment = var.environment
  account     = "payment"
  domains     = var.environment == "prod" ? local.pa_prod_domains : local.pa_non_prod_domains
}