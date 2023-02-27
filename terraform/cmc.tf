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
  zone_name     = "platform.hmcts.net"
  depends_on = [
    module.cmc
  ]
}