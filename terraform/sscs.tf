locals {
  sscs_non_prod_domains = ["mail-sscs-nonprod.platform.hmcts.net"] # there are multipe records for the non-prod but in order to not comlicate terraform script, I have added this domain and other domains are not managed using this tf code
  sscs_prod_domains     = []                                       # Setting empty until prod setup confirmed with SSCS team
}

module "sscs" {
  source      = "./modules/sendgrid"
  environment = var.environment
  account     = "sscs"
  domains     = var.environment == "prod" ? local.sscs_prod_domains : local.sscs_non_prod_domains
}

module "sscs_dns" {
  source      = "./modules/azure_dns"
  dns_records = module.sscs.dns_records
  zone_name   = "platform.hmcts.net"
}
