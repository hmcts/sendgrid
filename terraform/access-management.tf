locals {
  am_non_prod_domains = ["mail-am-nonprod.platform.hmcts.net"]
  am_prod_domains     = ["mail-am.platform.hmcts.net"]
}

module "access-management" {
  source      = "./modules/sendgrid"
  environment = var.environment
  account     = "access-management"
  domains     = var.environment == "prod" ? local.am_prod_domains : local.am_non_prod_domains
}

module "access-management-dns" {
  source      = "./modules/azure_dns"
  dns_records = module.access-management.dns_records
  depends_on = [
    module.access-management
  ]
}