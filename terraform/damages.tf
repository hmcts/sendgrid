locals {
  dm_non_prod_domains = ["mail-damages-nonprod.platform.hmcts.net"]
  dm_prod_domains     = ["mail-damages.platform.hmcts.net"]
}

module "damages" {
  source      = "./modules/sendgrid"
  environment = var.environment
  account     = "damages"
  domains     = var.environment == "prod" ? local.dm_prod_domains : local.dm_non_prod_domains
}

module "damages-dns" {
  source      = "./modules/azure_dns"
  dns_records = module.access-management.dns_records
  depends_on = [
    module.damages
  ]
}