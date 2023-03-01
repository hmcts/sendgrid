locals {
  prl_non_prod_domains = ["mail-prl-nonprod.platform.hmcts.net"] # there are multipe records for the non-prod but in order to not comlicate terraform script, I have added this domain and other domains are not managed using this tf code
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
