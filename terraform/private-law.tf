locals {
  prl_non_prod_domains = ["mail-prl-nonprod.aat.platform.hmcts.net", "mail-prl-nonprod.demo.platform.hmcts.net", "mail-prl-nonprod.ithc.platform.hmcts.net", "mail-prl-nonprod.perftest.platform.hmcts.net", "mail-prl-nonprod.preview.platform.hmcts.net"]
  prl_prod_domains     = ["mail-prl.platform.hmcts.net"]
}

module "private_law" {
  source      = "./modules/sendgrid"
  environment = var.environment
  account     = "private-law"
  domains     = var.environment == "prod" ? local.prl_prod_domains : local.prl_non_prod_domains
}

module "private_law_dns" {
  source      = "./modules/azure_dns"
  dns_records = module.private_law.dns_records
  zone_name   = "platform.hmcts.net"
}