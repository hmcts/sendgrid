locals {
  adoption_non_prod_domains = ["mail-adoption-nonprod.platform.hmcts.net"] # there are multipe records for the non-prod but in order to not comlicate terraform script, I have added this domain and other domains are not managed using this tf code
  adoption_prod_domains     = ["mail-adoption.platform.hmcts.net"]
}

module "adoption" {
  source      = "./modules/sendgrid"
  environment = var.environment
  account     = "adoption"
  domains     = var.environment == "prod" ? local.adoption_prod_domains : local.adoption_non_prod_domains
}

module "adoption_dns" {
  source      = "./modules/azure_dns"
  dns_records = module.adoption.dns_records
  zone_name   = "platform.hmcts.net"
}
