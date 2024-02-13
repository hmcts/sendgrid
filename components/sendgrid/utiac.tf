locals {
  utiac_non_prod_domains = ["nonprod-tribunalsdecisions-utiac.service.gov.uk"]
  utiac_prod_domains     = ["tribunalsdecisions-utiac.platform.service.gov.uk"]
}

module "utiac" {
  source      = "../modules/sendgrid"
  environment = var.env
  account     = "utiac"
  domains     = var.env == "prod" ? local.utiac_prod_domains : local.utiac_non_prod_domains
}

module "utiac-dns" {
  source      = "../modules/azure_dns"
  dns_records = module.utiac.dns_records
  zone_name   = "tribunalsdecisions.service.gov.uk"
}
