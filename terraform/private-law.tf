locals {
  pl_non_prod_domains = ["mail-prl-nonprod.aat.platform.hmcts.net", "mail-prl-nonprod.demo.platform.hmcts.net", "mail-prl-nonprod.ithc.platform.hmcts.net", "mail-prl-nonprod.perftest.platform.hmcts.net", "mail-prl-nonprod.preview.platform.hmcts.net"]
  pl_prod_domains     = ["mail-prl.platform.hmcts.net"]
}

module "private-law" {
  source      = "./modules/sendgrid"
  environment = var.environment
  account     = "private-law"
  domains     = var.environment == "prod" ? local.pl_prod_domains : local.pl_non_prod_domains
}

module "private-law-dns" {
  source      = "./modules/azure_dns"
  dns_records = module.access-management.dns_records
  depends_on = [
    module.private-law
  ]
}