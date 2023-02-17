locals {
  rd_non_prod_domains = ["mail-rd-nonprod.platform.hmcts.net"]
  rd_prod_domains     = ["mail-rd.platform.hmcts.net"]
}

module "reference-data" {
  source      = "./modules/sendgrid"
  environment = var.environment
  account     = "reference-data"
  domains     = var.environment == "prod" ? local.rd_prod_domains : local.rd_non_prod_domains
}

module "reference-data-dns" {
  source      = "./modules/azure_dns"
  dns_records = module.access-management.dns_records
  depends_on = [
    module.reference-data
  ]
}