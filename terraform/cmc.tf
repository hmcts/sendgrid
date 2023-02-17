locals {
  cm_non_prod_domains = ["mail-money-claims-nonprod.platform.hmcts.net"]
  cm_prod_domains     = ["mail-money-claims-prod.platform.hmcts.net"]
}

module "cmc" {
  source      = "./modules/sendgrid"
  environment = var.environment
  account     = "cmc"
  domains     = var.environment == "prod" ? local.cm_prod_domains : local.cm_non_prod_domains
}

module "cmc-dns" {
  source      = "./modules/azure_dns"
  dns_records = module.access-management.dns_records
  depends_on = [
    module.cmc
  ]
}