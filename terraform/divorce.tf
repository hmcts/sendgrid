locals {
  di_non_prod_domains = ["mail-divorce-nonprod.platform.hmcts.net"]
  di_prod_domains     = ["mail-divorce.platform.hmcts.net"]
}

module "divorce" {
  source      = "./modules/sendgrid"
  environment = var.environment
  account     = "divorce"
  domains     = var.environment == "prod" ? local.di_prod_domains : local.di_non_prod_domains
}

module "divorce-dns" {
  source      = "./modules/azure_dns"
  dns_records = module.access-management.dns_records
  depends_on = [
    module.divorce
  ]
}